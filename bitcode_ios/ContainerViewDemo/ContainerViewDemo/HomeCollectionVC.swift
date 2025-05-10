//
//  HomeCollectionVC.swift
//  ContainerViewDemo
//
//  Created by Deepak Kaligotla on 06/05/25.
//

import UIKit

protocol HomeCollectionVCDelegate: AnyObject {
    func didSelectPhotos(_ photos: [Photo])
}

class HomeCollectionVC: UIViewController {
    @IBOutlet weak var mainCollectionView: UICollectionView!
    weak var delegate: HomeCollectionVCDelegate?
    
    let api = APIData()
    var albums: [(albumId: Int, photos: [Photo])] = []
    var selectedPhotos: [Photo] = []
    var tableVC: HomeTableVC?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableVC = segue.destination as? HomeTableVC {
            self.tableVC = tableVC
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            let groupedPhotos = await api.getAPIResponse()
            self.albums = groupedPhotos.sorted(by: { $0.key < $1.key }).map { ($0.key, $0.value) }
            if let firstAlbum = self.albums.first {
                self.selectedPhotos = firstAlbum.photos
            }
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
                self.tableVC?.updatePhotos(self.selectedPhotos)
            }
        }
        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        self.mainCollectionView.register(nib, forCellWithReuseIdentifier: "CollectionCell")
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
    }
}

extension HomeCollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.mainCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MainCollectionViewCell
        let album = albums[indexPath.row]
        cell.menuItemLabel.text = "Album \(album.albumId)\n\(album.photos.count) photos"
        return cell
    }
}

extension HomeCollectionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAlbum = albums[indexPath.row]
        self.selectedPhotos = selectedAlbum.photos
        delegate?.didSelectPhotos(selectedAlbum.photos)
    }
}

extension HomeCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width-10)/4, height: collectionView.frame.height-10)
    }
}
