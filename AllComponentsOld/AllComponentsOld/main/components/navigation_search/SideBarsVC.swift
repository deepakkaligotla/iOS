//
//  SideBarsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

private let reuseIdentifier = "CollectionViewReusableCellIdentifier"

class SideBarsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class SideBarCollectionVC: UICollectionViewController {
    let sections = ["Section 1", "Section 2", "Section 3"]
    let items = [["Item 1", "Item 2", "Item 3"], ["Item 4", "Item 5", "Item 6"], ["Item 7", "Item 8", "Item 9"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
//        self.collectionView!.register(SideBarCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.collectionViewLayout = self.createSideBarLayout()
    }
    
    func createSideBarLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        }
        return layout
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SideBarCollectionViewCell
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
    }
}

class SideBarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
}
