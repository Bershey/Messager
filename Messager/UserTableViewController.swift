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
    var filterdUses: [User] = []


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }

  

}
