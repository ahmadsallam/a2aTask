//
//  Constant.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/20/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//

import UIKit

class Constant {
    
    static let colrsArray = [UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                             UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                             UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                             UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                             UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                             UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                             UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)]
    
    static let baseURL = "https://api.github.com/"
    static let usersAPI = "users"
    static let reposAPI = "repos"

    
    static func getURL(url: String) -> URL? {
        return URL(string: url)
    }

}
