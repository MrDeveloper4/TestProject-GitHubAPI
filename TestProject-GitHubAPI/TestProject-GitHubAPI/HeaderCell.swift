//
//  HeaderCell.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit
import SDWebImage
import Whisper

class HeaderCell: UITableViewCell {

    var user : User! = nil
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var publicGistsLabel: UILabel!
    @IBOutlet weak var publicReposLabel: UILabel!

    func configureWithUser(user : User) {
        self.userAvatarImageView.sd_setImageWithURL(NSURL(string: user.userAvatarImageView), placeholderImage: UIImage.init(named: "placeholder"))
        self.userBioLabel.text = user.userBioLabel
        self.followersCountLabel.text = "Followers - \(user.followersCountLabel)"
        self.followingCountLabel.text = "Following - \(user.followingCountLabel)"
        self.publicGistsLabel.text = "Public gists - \(user.publicGistsLabel)"
        self.publicReposLabel.text = "Public repos - \(user.publicReposLabel)"
        self.user = user
        
        if DataManager.returnUserById(user.id) == nil {
            deleteButton.alpha = 0
        }
    }
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func deleteButtonDidPress(sender: UIButton) {
        DataManager.removeUserWithId(user.id)
        sender.alpha = 0;
        showAlert("User removed from database")
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
    
}
