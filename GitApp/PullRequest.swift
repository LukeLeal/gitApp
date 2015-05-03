//
//  PullRequest.swift
//  GitApp
//
//  Created by Felipe Marques Ramos on 27/04/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import Foundation
import CoreData

class PullRequest: NSManagedObject {

    @NSManaged var labels: NSSet
    @NSManaged var project: Project
    @NSManaged var user: User
    @NSManaged var number: Double
    @NSManaged var lastUpdate: String
    @NSManaged var owner: String

    func addLabel(lab : Label){
        var mset : NSMutableSet = labels as! NSMutableSet;
        mset.addObject(lab);
        labels = NSSet(set: mset);
    }
    
    func removeAllLabels(){
        var mset : NSMutableSet = labels as! NSMutableSet;
        mset.removeAllObjects();
        labels = NSSet(set: mset);
    }
}
