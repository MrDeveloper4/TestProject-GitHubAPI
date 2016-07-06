//
//  RepCell.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit

class RepCell: UITableViewCell {

    @IBOutlet weak var repTitleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var branchesLabel: UILabel!

    func configureWithRep(project : Project) {
        self.repTitleLabel.text = project.repTitleLabel
        self.languageLabel.text = project.languageLabel
        self.starsLabel.text    = "\(project.starsLabel)"
        self.branchesLabel.text = "\(project.branchesLabel)"
    }
    
}
