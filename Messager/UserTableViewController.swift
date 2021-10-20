//
//  UserTableViewController.swift
//  Messager
//
//  Created by minmin on 2021/10/11.
//

import UIKit

class UserTableViewController: UITableViewController {
    // MARK: - Vars
    var allUsers: [User] = []
    var filterdUsers: [User] = []
    let searchController = UISearchController(searchResultsController: nil)


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadUsers()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell
        let user = searchController.isActive ? filterdUsers[indexPath.row] : allUsers[indexPath.row]
        cell.configureC(user: user)
        return cell
    }

    // MARK: - DownloadUsers
    private func downloadUsers() {
        FirebaseUserListener.shared.downloadAllUsersFromFirebase { allUsers in
            self.allUsers = allUsers
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


}
