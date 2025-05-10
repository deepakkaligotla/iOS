//
//  TodosViewController.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

import UIKit

class TodosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        Task {
            await viewModel.fetchTodos()
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        let todo = viewModel.todos[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.completed ? "✅" : "❌"
        return cell
    }
}
