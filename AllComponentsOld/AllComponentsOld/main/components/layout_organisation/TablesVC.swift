//
//  Lists_tablesVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class TablesVC: UIViewController {
    @IBOutlet weak var customTableView: UITableView!
    var tableSection: [String] = []
    var tableData: [[String]] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.createTData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customTableView.dataSource = self
        self.customTableView.delegate = self
    }
    
    private func createTData() {
        var i = 0
        for asciiValue in 65...90 {
            let character = String(UnicodeScalar(asciiValue)!)
            self.tableSection.append(character)
            self.tableData.append([character])
            for j in 0...4 {
                self.tableData[i].append(character+" \(j)")
            }
            i += 1
        }
    }
}

extension TablesVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.tableSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCVcell = tableView.dequeueReusableCell(withIdentifier: "TableVCReusable", for: indexPath) as! TableVCell
        homeCVcell.setup(with: self.tableData[indexPath.section][indexPath.row])
        return homeCVcell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.tableSection[section]
    }
}

extension TablesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class TableVCell: UITableViewCell {
    @IBOutlet weak var btn: UILabel!
    
    func setup(with btnTitle: String) {
        self.btn.text = btnTitle
    }
}
