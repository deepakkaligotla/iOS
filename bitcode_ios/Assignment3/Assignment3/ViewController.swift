//
//  ViewController.swift
//  Assignment3
//
//  Created by Deepak Kaligotla on 18/03/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerXibFile()
    }
    
    func registerXibFile() {
        let uiNib = UINib(nibName: "MyTVCell", bundle: nil)
        self.tableView.register(uiNib, forCellReuseIdentifier: "MyCell")
    }
    
    @IBAction func btnAddMenuItem(_ sender: Any) {
        tableView.beginUpdates()
        items.insert((itemID: 10, itemType: types.veg, itemName: "Samosa", itemDescription: "Indian famous snack item", itemPrice: 30.60, itemImage: "Samosa"), at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
}

//MARK: Row UI and Data Binding
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0
            ? items.filter { $0.itemType == .veg }.count
            : items.filter { $0.itemType == .nonVeg }.count
    }
    
    /*
     Cell Reuse: The primary goal is to reuse existing cells that have scrolled offscreen, rather than creating new ones for every visible cell.
     
     Performance: This significantly improves performance, especially when dealing with large datasets, as it avoids the overhead of creating new cells repeatedly.
     
     Memory Efficiency: By reusing cells, you reduce the amount of memory required to display the table or collection view
    */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vegItems = items.filter { $0.itemType == .veg }
        let nonVegItems = items.filter { $0.itemType == .nonVeg }

        let item = (indexPath.section == 0) ? vegItems[indexPath.row] : nonVegItems[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyTVCell
        cell.itemImage.image = UIImage(named: item.itemImage)
        cell.itemName.text = item.itemName
        cell.itemPrice.text = "₹ \(item.itemPrice)"
        
        cell.onDelete = { [weak self] in
            guard let self = self else { return }
            let cell = tableView.cellForRow(at: indexPath) as? MyTVCell
            let itemName = cell?.itemName.text
            if let name = itemName, let index = items.firstIndex(where: { $0.itemName == name }) {
                items.remove(at: index)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                tableView.reloadData()
            }
        }
        
        return cell
    }
}

//MARK: Sections & Headers
extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cell = tableView.cellForRow(at: indexPath) as? MyTVCell
            let itemName = cell?.itemName.text
            if let name = itemName, let index = items.firstIndex(where: { $0.itemName == name }) {
                items.remove(at: index)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "🥗 Vegetarian" : "🍗 Non-Vegetarian"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            header.textLabel?.textColor = UIColor.systemGreen
            header.contentView.backgroundColor = UIColor.systemGray6
        }
    }
}

//MARK: Row Height
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemVC = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        
        let selectedItem = (indexPath.section == 0)
            ? items.filter { $0.itemType == .veg }[indexPath.row]
            : items.filter { $0.itemType == .nonVeg }[indexPath.row]
        
        itemVC.itemIDFromVC = selectedItem.itemID
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
}
