//
//  Project.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit
import RealmSwift

class Project: Object {
    dynamic var repTitleLabel = ""
    dynamic var languageLabel = ""
    dynamic var starsLabel = 0
    dynamic var branchesLabel = 0
    
    override static func primaryKey() -> String? {
        return "repTitleLabel"
    }
}

