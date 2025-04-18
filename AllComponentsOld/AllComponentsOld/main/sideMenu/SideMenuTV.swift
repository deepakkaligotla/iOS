//
//  HomeTable.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 05/05/24.
//

import Foundation
import UIKit

extension SideMenuVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        FetchData().getAllCategories().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < FetchData().getAllCategories().count else {
            return 0
        }
        return FetchData().getAllCategories()[section].component?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCVcell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTVCReusable", for: indexPath) as! SideMenuTVC
        homeCVcell.setup(with: FetchData().getCategoryComponents(selectedCategory: FetchData().getAllCategories()[indexPath.section].name!)[indexPath.row])
        return homeCVcell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FetchData().getAllCategories()[section].name
    }
}

extension SideMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let identifier = FetchData().getCategoryComponents(selectedCategory: FetchData().getAllCategories()[indexPath.section].name!)[indexPath.row].vcIdentifier {
            SideMenuVC.delegate?.displayViewController(withIdentifier: identifier)
        }
    }
}
