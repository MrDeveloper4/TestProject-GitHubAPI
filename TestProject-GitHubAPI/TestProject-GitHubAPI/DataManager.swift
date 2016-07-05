//
//  DataManager.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit
import RealmSwift

class DataManager: NSObject {

    class func isEmpty() -> Bool {
        let realm = try! Realm()
        let users = realm.objects(User.self)
        if users == 0 {
            return true
        } else{
            return false
        }
    }
    
    class func returnUserById(id : String) -> User? {
        let realm = try! Realm()
        let usersArray = realm.objects(User.self).filter("id = '\(id)'")
        if usersArray.count != 0 {
            return usersArray[0]
        } else{
            return nil
        }
    }
    
    class func addUser(user : User) {
        let realm = try! Realm()
        let usersArray = realm.objects(User.self).filter("id = '\(user.id)'")
        try! realm.write {
            realm.add(usersArray[0], update: true)
        }
        //If user is in a dataBase we simply update the info
    }
    
    class func removeUserWithId(id : String) {
        let realm = try! Realm()
        let usersArray = realm.objects(User.self).filter("id = '\(id)'")
        try! realm.write {
            realm.delete(usersArray[0])
        }
    }
}
