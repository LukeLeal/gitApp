//
//  DataManager.swift
//  GitApp
//
//  Created by Lucas Leal Mendonça on 28/04/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import CoreData
import UIKit

class DataManager: NSObject {
    
    static let sharedInstance = DataManager();
    
    var context : NSManagedObjectContext?;
    
    private override init(){}

    func insereDadosPadrao(){
        var u : User = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context!) as! User;
        u.name = "Daniel Orivaldo da Silva";
        
        var u2: User = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context!) as! User;
        u2.name = "Churrasqueira Controle Remoto";
        var error: NSError? = nil
        if context!.hasChanges && !context!.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
    }
    
    func searchEntity (entity : String) -> NSArray{
        var fr : NSFetchRequest = NSFetchRequest();
        
        fr.entity = NSEntityDescription.entityForName(entity, inManagedObjectContext: context!);
        
        var fetchedObjects : NSArray = context!.executeFetchRequest(fr, error: nil)!;
        return fetchedObjects;
    }
    
    func updateUser(oldName : String, newName : String){
        var fr : NSFetchRequest = NSFetchRequest();
        
        fr.entity = NSEntityDescription.entityForName("User", inManagedObjectContext: context!);
        //fr.predicate =  NSPredicate(format: String.stringByAppendingFormat("hue"), arguments: nil)
        fr.predicate = NSPredicate(format: "name == %@", oldName);
        
//        var fetchedObjects : NSArray = context!.executeFetchRequest(fr, error: nil)!;
        
        if let fetchResults = context!.executeFetchRequest(fr, error: nil) as? [NSManagedObject] {
            if fetchResults.count != 0{
                
                var managedObject = fetchResults[0]
                managedObject.setValue(newName, forKey: "name")
                
                context!.save(nil)
            }
        }
        
    }
    
}


