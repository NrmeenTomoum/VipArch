//
//  HomeWorker.swift
//  TentBearTask
//
//  Created by Nrmeen Tomoum on 09/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//


import UIKit

class HomeWorker
{
    // to call Alomafire to get list of user from api 
    func getListOfUsers(completionHandler: @escaping (Home.Users.UsersResponseInfo?,ErrorCode?) -> Void)
    {
        RequestService.sendHttpRequest(httpMethod: .get,
                                       url: Constants.Server.Services.getUsersURL,
                                       objectType: Home.Users.UsersResponseInfo.self, isRelativeUrl: false, params: nil, isAuth: false,
                                       customHeaders: [:],
                                       body: [:])
        { result, error  in
            if let authRespond = result
            {
                print(authRespond)
                completionHandler(authRespond ,nil )
            }
            else
            {
                if let apiEror = error
                {
                    print(apiEror)
                    completionHandler(nil , apiEror)
                } else
                {
                    completionHandler(nil , ErrorCode.UNKOWN_ERROR)
                }
            }
            
        }
        
    }
}

