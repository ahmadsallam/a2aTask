//
//  UserObject.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/21/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//

import UIKit

class UserObject {
   
    var id: Int?,
    name: String?,
    avatar_url: String?,
    public_repos: Int?,
    repos_url: String?
    
    enum CodingKeys: String , CodingKey {
        case id = "id"
        case name = "name"
        case profileImageURL = "avatar_url"
        case numberOfPublicRepository = "public_repos"
        case publicRepositoryURL = "repos_url"
    }
    
    init(){}
    
    init(id: Int!,
         name: String!,
         avatar_url: String!,
         public_repos: Int!,
         repos_url: String!) {
        
        self.name = name
        self.id = id
        self.avatar_url = avatar_url
        self.public_repos = public_repos
        self.repos_url = repos_url
    }
    
}
