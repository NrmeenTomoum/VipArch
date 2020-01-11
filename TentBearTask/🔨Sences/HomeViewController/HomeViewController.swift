//
//  HomeViewController.swift
//  TentBearTask
//
//  Created by Nrmeen Tomoum on 09/01/2020.
//  Copyright © 2020 Nermeen. All rights reserved.
//

import UIKit
import FCAlertView
import CoreData
import SDWebImage

protocol HomeDisplayLogic: class
{
    func displayListOfUsers(viewModel: [Home.Users.Response])
    func displayIndecator()
    func stopIndecator()
    func createAlert(title: String, subTitle: String)
}

class HomeViewController:  UITableViewController,HomeDisplayLogic
{
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    var viewIndecator = loader ()
    var displayedUsers: [Home.Users.Response] = []
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // request List of Users from APi  need to call worker through interactor VIP Clean swift code Arcticture
        getListOfUsers()
    }
    
    // MARK: Do something
    // to show message in alert view in View
    func createAlert(title: String, subTitle: String) {
        CAlert.createAlert(title: title, subTitle: subTitle,vc: self)
    }
    
    // to show indecator
    func displayIndecator()
    {
        viewIndecator.startIndecator(self.view)
    }
     // to stop indecator
    func stopIndecator()
    {
        viewIndecator.stopIndecator(self.view)
    }
    //   to show List of reloaded user in View
    func displayListOfUsers(viewModel: [Home.Users.Response]) {
        displayedUsers = viewModel
        var setOfUsersFromCD: [NSManagedObject] = []
        DBManger.fetchCD("User", dataRetrived: &setOfUsersFromCD)
        print(setOfUsersFromCD)
        tableView.reloadData()
    }
    
    func getListOfUsers()
    {
        interactor?.getListOfUsers()
    }
}

extension HomeViewController: FCAlertViewDelegate
{
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
    }
}
//  Table view data source
extension HomeViewController
    
{
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return displayedUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let displayedUser = displayedUsers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCustomCell
     
        cell.firstName?.text = displayedUser.first_name
        cell.lastName?.text = displayedUser.last_name
        //   cell?.imageView?.image = UIImage(named: "image")
        cell.userImagew?.sd_setImage(with: URL(string: displayedUser.avatar!), placeholderImage: UIImage(named: "image"))
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetails(segue: nil)
    }
}
