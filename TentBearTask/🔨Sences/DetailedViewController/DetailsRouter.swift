//
//  DetailsRouter.swift
//  TentBearTask
//
//
//  Created by Nrmeen Tomoum on 09/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit

@objc protocol DetailsRoutingLogic
{
}

protocol DetailsDataPassing
{
    var dataStore: DetailsDataStore? { get }
}

class DetailsRouter: NSObject, DetailsRoutingLogic, DetailsDataPassing
{
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
}
