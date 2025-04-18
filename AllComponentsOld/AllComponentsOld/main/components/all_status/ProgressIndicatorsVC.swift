//
//  ProgressIndicatorsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class ProgressIndicatorsVC: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0.0
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        tableView.refreshControl = refreshControl
        simulateProgress()
    }

    func simulateProgress() {
        var progress: Float = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            progress += 0.05
            self.progressView.progress = progress
            if progress >= 1.0 {
                timer.invalidate()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }

    @objc func handleRefreshControl() {
        self.simulateProgress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}

extension ProgressIndicatorsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RefreshTC", for: indexPath)
        cell.textLabel?.text = "Item \(indexPath.row + 1)"
        return cell
    }
}

