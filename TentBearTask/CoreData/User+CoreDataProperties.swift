//
//  User+CoreDataProperties.swift
//  
//
//  Created by Nrmeen Tomoum on 09/01/2020.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var email: String?
    @NSManaged public var first_name: String?
    @NSManaged public var id: Int16
    @NSManaged public var second_name: String?

}
