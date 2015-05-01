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
    
    func searchEntity (entity : String, predicate : String) -> NSManagedObject{
        var fr : NSFetchRequest = NSFetchRequest();
        
        fr.entity = NSEntityDescription.entityForName(entity, inManagedObjectContext: context!);
        fr.predicate = NSPredicate(format: predicate);
        
        var fetchedObjects : NSArray = context!.executeFetchRequest(fr, error: nil)!;
        return fetchedObjects.objectAtIndex(0) as! NSManagedObject;
    }
    
//    func searchPR (predicate : String) -> NSManagedObject{
//        var fr : NSFetchRequest = NSFetchRequest();
//        
//        fr.entity = NSEntityDescription.entityForName("PullRequest", inManagedObjectContext: context!);
//        fr.predicate = NSPredicate(format: "number == %@", predicate);
//        
//        var fetchedObjects : NSArray = context!.executeFetchRequest(fr, error: nil)!;
//        return fetchedObjects.objectAtIndex(0) as! NSManagedObject;
//    }
    
    func compareEntity(entity:String, predicate : String)-> Bool{
        var fr : NSFetchRequest = NSFetchRequest()
        
        fr.entity = NSEntityDescription.entityForName(entity, inManagedObjectContext: context!)
        fr.predicate = NSPredicate(format: predicate)
        
        if let fetchResults = context!.executeFetchRequest(fr, error: nil) as? [NSManagedObject]{
            if fetchResults.count != 0{
                return true
            }
            
        }
        return false
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
    
    func insertProject(name:String){
        var predicate = "name == '\(name)'";
        if !compareEntity("Project", predicate: predicate){
            var h : Project = NSEntityDescription.insertNewObjectForEntityForName("Project", inManagedObjectContext: context!) as! Project
            h.name = name
            
            context!.save(nil)
        }
    }
    
    func insertPullRequest(number:String, projectName:String){//, labels : Array<NSDictionary>){
        
        var predicate = "project.name == '\(projectName)' AND number == \(number)";
        if !compareEntity("PullRequest", predicate: predicate){
            var e : PullRequest = NSEntityDescription.insertNewObjectForEntityForName("PullRequest", inManagedObjectContext: context!) as! PullRequest
            e.number = Double(number.toInt()!);//Arrumar se der tempo
            e.project = searchEntity("Project", predicate: "name == '\(projectName)'") as! Project;
            e.lastUpdate = "not set";
//            for item in labels {
//                var label = NSEntityDescription.insertNewObjectForEntityForName("Labels", inManagedObjectContext: context!) as! Label;
//                label.name = item.valueForKey("name") as! String;
//                //Seta tipoq
//                if(Array(label.name)[0] != "P"){
//                    label.type = String(Array(label.name)[0]);
//                } else {
//                    label.type = String(Array(label.name)[4]);
//                }
//                //Label tá sem relaçao com PR. Nao que isso seja um problema realmente
//                e.addLabel(label);
//            }
        
            context!.save(nil)
        }

    }
    
    func updatePRLabels(number:String, projectName:String, attDate : String, labels : Array<NSDictionary>){
        //Busca o PR
        var pr = searchEntity("PullRequest", predicate: "project.name == '\(projectName)' AND number == \(number)") as? PullRequest;
        //Verifica diferença nas datas de atualização
        if(!(pr!.lastUpdate == attDate)){
            pr!.lastUpdate = attDate;
            //Tira todos as labels do NSSet.
            pr!.removeAllLabels();
            //Adiciona tudo de novo. [/lazyMode]
            for item in labels {
                var label = NSEntityDescription.insertNewObjectForEntityForName("Label", inManagedObjectContext: context!) as! Label;
                label.name = item.valueForKey("name") as! String;
                //Setagem do tipo [/cancer]
                if(Array(label.name)[0] != "P"){
                    label.type = String(Array(label.name)[0]);
                } else {
                    label.type = String(Array(label.name)[4]);
                }
                //Label tá sem relaçao com PR. Nao que isso seja um problema realmente
                pr!.addLabel(label);
            }
            context?.save(nil);
        } else {
            println("Nem precisa hue");
        }
    }
}


