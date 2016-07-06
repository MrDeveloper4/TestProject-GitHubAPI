//
//  DetailVC.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit
import Whisper

class DetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var currentUser : User!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.edgesForExtendedLayout = UIRectEdge.None
        navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
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
        let menuArray = [KxMenuItem.init("Open in browser", image: nil, target: self, action: #selector(DetailVC.openInBrowserClicked)),
                         KxMenuItem.init("Save", image: UIImage(named: "Touch"), target: self, action: #selector(DetailVC.saveClicked)),
                         KxMenuItem.init("Share", image: UIImage(named: "Touch"), target: self, action: #selector(DetailVC.shareClicked))]
        
        KxMenu.setTitleFont(UIFont(name: "AvenirNext", size: 15))
        
        let options = OptionalConfiguration(arrowSize: 9,
            marginXSpacing: 7,
            marginYSpacing: 9,
            intervalSpacing: 25,
            menuCornerRadius: 6.5,
            maskToBackground: true,
            shadowOfMenu: false,
            hasSeperatorLine: true,
            seperatorLineHasInsets: false,
            textColor: Color(R: 0, G: 0, B: 0),
            menuBackgroundColor: Color(R: 1, G: 1, B: 1))
        
        KxMenu.showMenuInView(self.view, fromRect: CGRectMake(view.bounds.size.width - 20, 5, 1, 1), menuItems: menuArray, withOptions: options)
    }
    
    func openInBrowserClicked() {
        if !WebManager.isConnectedToNetwork() {
            showAlert("No internet connection", color: UIColor.redColor())
            return
        }
        let browser = KAWebBrowser()
        showViewController(browser, sender: nil)
        browser.loadURLString("https://github.com/\(currentUser.id.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))")
    }
    func saveClicked() {
        DataManager.addUser(currentUser)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0)) as! HeaderCell
        cell.deleteButton.alpha = 1
        showAlert("User saved to database")
    }
    
    func shareClicked() {
        let textToShare = "Awesome GitHub user."
        let link = NSURL(string: "https://github.com/\(currentUser.id.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))")
        
        let activityViewController = UIActivityViewController(
            activityItems: [textToShare, link!],
            applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - Alert
    func showAlert(text : String) {
        let murmur = Murmur(title: text)
        // Show and hide a message after delay
        Whistle(murmur) // Whistle(murmur, action: .Show(1.5))
        // Present a permanent status bar message
        Whistle(murmur, action: .Present)
        // Hide a message
        Calm()
    }
    
    func showAlert(text : String, color : UIColor) {
        let message = Message(title: text, backgroundColor: color)
        // Show and hide a message after delay
        Whisper(message, to: navigationController!, action: .Show)
        // Present a permanent message
        Whisper(message, to: navigationController!, action: .Present)
        // Hide a message
        Silent(navigationController!)
    }

    
}
