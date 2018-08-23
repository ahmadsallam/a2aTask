//
//  JSONParser.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/22/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//

import UIKit
import Alamofire

class JSONParser {
    
    static func parseUserObject(response: [String:Any]) -> UserObject? {
        
        let user = UserObject(id: response["id"] as? Int,
                              name: response["name"] as? String,
                              avatar_url: response["avatar_url"] as? String,
                              public_repos: response["public_repos"] as? Int,
                              repos_url: response["public_repos"] as? String)
        
        
        return user
    }
    
    static func parseReposList(response: [Any]) -> [RepositoryObject]? {
        
        var repositoryArray = [RepositoryObject]()
        
        for repositoryObject in response {
            if let repository = repositoryObject as? [String:Any] {
                let object = RepositoryObject(name: repository["name"] as? String,
                                              forks_count: repository["forks_count"] as? Int,
                                              watchers_count:  repository["watchers_count"] as? Int)
                repositoryArray.append(object)
            }
        }
        return repositoryArray
    }
    
    
}

