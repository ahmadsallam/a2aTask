//
//  RepositoryObject.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/22/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//

import UIKit

class RepositoryObject {
    
    var name: String?,
        forks_count: Int?,
        watchers_count: Int?
    
    init(name: String!,
         forks_count: Int!,
         watchers_count: Int!) {
        
        self.watchers_count = watchers_count
        self.forks_count = forks_count
        self.name = name
    }
    
    init(){}
    
    
}
