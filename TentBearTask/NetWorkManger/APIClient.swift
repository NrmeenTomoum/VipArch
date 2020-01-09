////
//
//  NetWorkManger.swift
//  MessageView
//
//  Created by iOS on 5/22/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class RequestService {
    static var  alomafireObjectForMocking: NetWorkBusinessLogic? = MainRequest()
    static func sendHttpRequest<T: Decodable>(httpMethod: HTTPMethod,
                                              url: String, objectType: T.Type? = T.self,
                                              isRelativeUrl: Bool? = true,
                                              params: Parameters?=nil,
                                              isAuth: Bool? = true,
                                              customHeaders: [String: String]?=nil,
                                              body: Parameters?=nil,
                                              completion:@escaping  (T?, ErrorCode?) -> Void ) {
        let urlPath = URL(string: RequestUtilty.prepareQueryParameters(
            RequestUtilty.prepareUrl(isRelativeUrl: isRelativeUrl!, url: url).absoluteString,
            params: params as? [String: String])!)!
//        if  isAuth! && RequestUtilty.isValidToken() {
//            sendHttpRequest(httpMethod: .post,
//                            url: "http://52.25.21.235:8080/refresh-token", objectType: LoginResponse.self,
//                            isRelativeUrl: false, params: nil, isAuth: false,
//                            customHeaders: ["Authorization": "Basic bW9iaWxlOnBpbg==",
//                                            "Content-Type": "application/x-www-form-urlencoded"],
//                            body: ["grantType": "refresh-token", "refreshToken": UserStatus.getRefreshToken()])
//            {  result, error  in
//                if let authRespond = result
//                { UserStatus.setToken(token: authRespond.accessToken!)
//                    UserStatus.setRefreshToken(token: authRespond.refreshToken!)
//                    UserStatus.setTokenTimestamp(tokenTimestamp: authRespond.accessTokenUnixExpiry!)
//                    let finalHeaders = RequestUtilty.prepareHeader(
//                        isAuth: isAuth!, customHeaders: customHeaders)
//                    RequestService.alomafireObjectForMocking!.sendHttpRequest(objectType: T.self,
//                                                                              httpMethod: httpMethod,
//                                                                              pathOfURL: urlPath,
//                                                                              isRelativeUrl: isRelativeUrl,
//                                                                              params: params,
//                                                                              isAuth: isAuth,
//                                                                              customHeaders: finalHeaders ,
//                                                                              body: body,
//                                                                              completion: { response, error  in
//                                                                                completion(response, error)})} else
//                {
//                    UserStatus.logout()
//                }}}
        let finalHeaders = RequestUtilty.prepareHeader(
            isAuth: isAuth!, customHeaders: customHeaders)
        RequestService.alomafireObjectForMocking!.sendHttpRequest(objectType: T.self,
                                                                  httpMethod: httpMethod, pathOfURL: urlPath,
                                                                  isRelativeUrl: isRelativeUrl, params: params,
                                                                  isAuth: isAuth, customHeaders: finalHeaders,
                                                                  body: body, completion: { (response, error) in
                                                                    completion(response, error)     })}}
