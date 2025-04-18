//
//  SearchVC.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 20/06/24.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchQuery: String? {
        didSet {
            updateSearchQuery()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchQuery()
    }
    
    func updateSearchQuery() {
        self.searchBar?.text = searchQuery ?? "Search what you are looking for"
    }
}
