//
//  DetailsPresenter.swift
//  TentBearTask
//
//  Created by Nrmeen Tomoum on 09/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit

protocol DetailsPresentationLogic
{
    func presentUserInfo(response: Home.Users.Response)
}

class DetailsPresenter: DetailsPresentationLogic
{
  weak var viewController: DetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentUserInfo(response: Home.Users.Response)
  {
    viewController?.displayUserInfo(viewModel: response)
  }
}
