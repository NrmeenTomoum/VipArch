//
    //  RequestService.swift
    //  MessageView
    //
    //  Created by iOS on 5/29/19.
    //  Copyright © 2019 iOS. All rights reserved.
    //

    import Foundation
    import Alamofire
    import SwiftyJSON
enum ErrorCode: String {
    case ACCESS_TOKEN_MISSING
    case ACCESS_TOKEN_INVALID
    case ACCESS_TOKEN_EXPIRED
    case  USER_NOT_LOGGED_IN
    case  GRANT_TYPE_MISSING
    case GRANT_TYPE_INVALID
    case  USERNAME_MISSING
    case PASSWORD_MISSING
    case CREDENTIALS_INVALID
    case REFRESH_TOKEN_MISSING
    case REFRESH_TOKEN_INVALID
    case REFRESH_TOKEN_EXPIRED
    case SERVER_DOWN
    case DECODE_ERROR
    case UNKOWN_ERROR
}
struct APIError: Codable {
    var errorCode: String?
}
    protocol NetWorkBusinessLogic {
        func  sendHttpRequest<T: Decodable>(objectType: T.Type, httpMethod: HTTPMethod,
                                            pathOfURL: URL, isRelativeUrl: Bool?, params: Parameters?, isAuth: Bool?,
                                            customHeaders: HTTPHeaders?, body: Parameters?, decoder: JSONDecoder,
                                            completion:@escaping (T?, ErrorCode?) -> Void)
    }
    // solving default params problem
    extension NetWorkBusinessLogic {
        func  sendHttpRequest<T: Decodable>( objectType: T.Type, httpMethod: HTTPMethod, pathOfURL: URL,
                                             isRelativeUrl: Bool? = true, params: Parameters?=nil, isAuth: Bool? = true,
                                             customHeaders: HTTPHeaders?=nil,
                                             body: Parameters?=nil, decoder: JSONDecoder = JSONDecoder(),
                                             completion:@escaping  (T?, ErrorCode?) -> Void) {
            return  sendHttpRequest(objectType: objectType, httpMethod: httpMethod, pathOfURL: pathOfURL,
                                    isRelativeUrl: isRelativeUrl, params: params, isAuth: isAuth,
                                    customHeaders: customHeaders,
                                    body: body, decoder: decoder, completion: completion)
        }
    }

    class MainRequest: NetWorkBusinessLogic {
        func  sendHttpRequest<T: Decodable>(objectType: T.Type, httpMethod: HTTPMethod, pathOfURL: URL,
                                            isRelativeUrl: Bool? = true, params: Parameters?=nil, isAuth: Bool? = true,
                                            customHeaders: HTTPHeaders?=nil, body: Parameters?=nil,
                                            decoder: JSONDecoder = JSONDecoder(),
                                            completion:@escaping (T?, ErrorCode?) -> Void) {
            let dataRequest = AF.request(pathOfURL, method: httpMethod, parameters: body,
                                         encoding: URLEncoding.default,
                                         headers: customHeaders)
            dataRequest.responseJSON { response in
                let respons = response.result
                switch respons{
                case .success:
                    let status = response.response?.statusCode
                    if status == 200
                    {
                        do {
                            let model  = try decoder.decode(T.self, from: response.data!)
                            completion(model, nil)
                        } catch _ {
                            completion(nil, ErrorCode.DECODE_ERROR)
                        }
                    } else
                    {
                        do {
                            let model = try decoder.decode(APIError.self, from: response.data!)
                               completion(nil, ErrorCode(rawValue: model.errorCode ?? "UNKOWN_ERROR"))
                        } catch _ {
                            completion(nil, ErrorCode.DECODE_ERROR)
                        }
                    }
                case .failure:
                    completion(nil,
                               ErrorCode.SERVER_DOWN)
                    // network connection errror or server down
                }
            }
        }
    }
