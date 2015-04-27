//
//  Project.swift
//  GitApp
//
//  Created by Felipe Marques Ramos on 27/04/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import Foundation
import CoreData

class Project: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var readMe: String
    @NSManaged var pullRequests: NSSet

}
