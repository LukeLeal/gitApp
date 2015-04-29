//
//  User.swift
//  GitApp
//
//  Created by Lucas Leal Mendonça on 28/04/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var password: String
    @NSManaged var pullRequests: NSSet

}
