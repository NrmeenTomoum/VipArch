//
//  HomeModels.swift
//  TentBearTask
//
//  Created by Nrmeen Tomoum on 09/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit

enum Home
{
  // MARK: Use cases
  
  enum Users
  {
    struct UsersResponseInfo: Codable {
        var page: Int?
        var  per_page: Int?
        var     total: Int?
        var total_pages: Int?
        var data: [Home.Users.Response]?
    }
    
    struct Response: Codable {
        var id: Int?
        var  email: String?
        var     first_name: String?
        var last_name: String?
        var avatar: String?
    }
  }
}
