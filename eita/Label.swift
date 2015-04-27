//
//  Label.swift
//  GitApp
//
//  Created by Felipe Marques Ramos on 27/04/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import Foundation
import CoreData

class Label: NSManagedObject {

    @NSManaged var type: String
    @NSManaged var name: String
}
