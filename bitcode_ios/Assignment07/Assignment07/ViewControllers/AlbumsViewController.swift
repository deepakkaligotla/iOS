//
//  AlbumsViewController.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

import UIKit

class AlbumsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var albumViewModel = AlbumViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AlbumCell")
        Task {
            await albumViewModel.fetchAlbums()
            collectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumViewModel.albums.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }
        let album = albumViewModel.albums[indexPath.row]
        cell.configure(with: album)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.width / 3) - 10),
                    height: ((collectionView.frame.width / 3) - 10))
    }
}
