//
//  WebManager.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit
import SystemConfiguration
import Alamofire
import SwiftyJSON
import RealmSwift

class WebManager: NSObject {

    static let baseURL = "https://api.github.com/"
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    class func getUserById(id: String, completion : (user : User?)->()) {
        let urlString = baseURL + "users/" + id.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        Alamofire.request(.GET, NSURL(string: urlString)!, parameters: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let user = User()
                        user.id = id
                        user.userAvatarImageView = json["avatar_url"].string!
                        user.userBioLabel = json["name"].string! + ", " + json["company"].stringValue + ", " + json["email"].stringValue
                        user.followersCountLabel = json["followers"].int!
                        user.followingCountLabel = json["following"].int!
                        user.publicGistsLabel = json["public_gists"].int!
                        user.publicReposLabel = json["public_repos"].int!
                        
                        //----Get Repositories
                        let urlString = json["repos_url"].string!
                        
                        Alamofire.request(.GET, NSURL(string: urlString)!, parameters: nil)
                            .validate()
                            .responseJSON { response in
                                switch response.result {
                                case .Success:
                                    if let value = response.result.value {
                                        let json = JSON(value)
                                        for (_, value) in json {
                                            let newProject = Project()
                                            newProject.repTitleLabel = value["name"].string!
                                            newProject.languageLabel = value["language"].stringValue
                                            newProject.starsLabel = value["stargazers_count"].int!
                                            newProject.branchesLabel = value["forks_count"].int!
                                            user.repositories.append(newProject)
                                        }
                                        completion(user: user)
                                    }
                                case .Failure(let error):
                                    print(error)
                                }
                        }
                        //----Get Repositories
                    }
                case .Failure(let error):
                    print(error)
                    completion(user: nil)
                }
        }
    }
    
}


//dynamic var repTitleLabel = ""
//dynamic var languageLabel = ""
//dynamic var starsLabel = ""
//dynamic var branchesLabel = ""
