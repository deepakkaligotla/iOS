//
//  ViewController.swift
//  NestedTableNCollection
//
//  Created by Deepak Kaligotla on 26/03/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        registerXibFile()
    }
    
    func initViews() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func registerXibFile() {
        let uiNib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(uiNib, forCellReuseIdentifier: "TVCell")
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TableViewCell
        let sectionItems = items.filter { $0.itemType == Section.allCases[indexPath.section] }
        cell.configure(with: sectionItems)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section.allCases[section].rawValue
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            header.textLabel?.textColor = UIColor.systemGreen
            header.contentView.backgroundColor = UIColor.systemGray6
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ViewController: TableViewCellDelegate {
    func didSelectItem(_ item: Item) {
        let itemVC = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        itemVC.selectedItem = item
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
}
