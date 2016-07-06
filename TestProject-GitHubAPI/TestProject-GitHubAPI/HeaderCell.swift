//
//  HeaderCell.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit
import SDWebImage

class HeaderCell: UITableViewCell {

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
    }
}
