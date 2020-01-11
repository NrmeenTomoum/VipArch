//
//  DetailsInteractor.swift
//  TentBearTask
//
//
//  Created by Nrmeen Tomoum on 09/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit

protocol DetailsBusinessLogic
{
    func getUserInfo()
}

protocol DetailsDataStore
{
    var user: Home.Users.Response? { get set }
}

class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore
{
    var user: Home.Users.Response?
    
    var presenter: DetailsPresentationLogic?
        // MARK: Do something
    
    func getUserInfo()
    {
        if   let response = user
        {
            presenter?.presentUserInfo(response: response)
        }
    }
}
