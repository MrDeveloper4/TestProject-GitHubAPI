//
//  DetailVC.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var currentUser : User!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    //MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUser.repositories.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 179
        } else {
            return 80
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell0") as! HeaderCell!
            cell.selectionStyle = .None
            cell.configureWithUser(currentUser)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! RepCell!
            cell.selectionStyle = .None
            cell.configureWithRep(currentUser.repositories[indexPath.row - 1])
            return cell
        }
    }
    
    //MARK: - BarButtonItem
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBAction func barButtonDidPress(sender: UIBarButtonItem) {
    }

}
