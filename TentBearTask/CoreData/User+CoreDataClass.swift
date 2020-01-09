//
//  User+CoreDataClass.swift
//  
//
//  Created by Nrmeen Tomoum on 09/01/2020.
//
//

import Foundation
import CoreData
import UIKit



@objc(User)
public class User: NSManagedObject {
    
}
class DBManger{
    class  func save(user: Home.Users.Response) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "User",
                                       in: managedContext)!
        
        let userCD = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        // 3
        userCD.setValue(user.id, forKeyPath: "id")
        userCD.setValue(user.avatar, forKeyPath: "avatar")
        userCD.setValue(user.first_name, forKeyPath: "first_name")
        userCD.setValue(user.last_name, forKeyPath: "last_name")
        userCD.setValue(user.email, forKeyPath: "email")
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    class  func fetchCD (_ tableName: String, dataRetrived:inout [NSManagedObject]) {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        print("tableName ===>s",tableName)
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: tableName)
        
        //3
        do {
            dataRetrived = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
