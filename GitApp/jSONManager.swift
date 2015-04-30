//
//  jSONManager.swift
//  GitApp
//
//  Created by Felipe Marques Ramos on 29/04/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import UIKit

class jSONManager: NSObject {
    
    let clientID = "8fb09c4abdef8660c7a4"
    let clientSecret = "562c127dd23de151e09483cea87b0e64ab58514c"
    var dm: DataManager = DataManager.sharedInstance
    
    func buscarRepos(user:String!){
        
        
        var path = "users/mackmobile/repos"
        var url = NSURL(string: "https://api.github.com/\(path)?client_id=\(clientID)&client_secret=\(clientSecret)")
        
        
        var jsonData = NSData(contentsOfURL: url!)
        var jsonRes: AnyObject? = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        var resultado = jsonRes as! Array<NSDictionary>
        
        var repos = Array<String>()
        
        for item in resultado{
            let repo = item.objectForKey("full_name") as! String
            if verificarPulls(user, path: repo){
                println(repo)
                dm.insertProject(repo)
                let numPull = self.getPull(repo, usuario: user)
                
                if numPull != ""{
                    dm.insertPullRequest(numPull, projectName: repo)
                    
                }
                self.getLabel(numPull, path: repo)
//                println(self.getLabel(numPull, path: repo))
                repos.append(repo)
            }
        }
    }
    
    func verificarPulls(usuario:String, path:String)->Bool{
        
        var url = NSURL(string: "https://api.github.com/repos/\(path)/pulls?client_id=\(clientID)&client_secret=\(clientSecret)")
        
        
        var jsonData = NSData(contentsOfURL: url!)
        var jsonRes: AnyObject! = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        var resultado = jsonRes as! Array<NSDictionary>
        
        //        var tdsRepos = Array<String>()
        
        for item in resultado{
            
            let user = item.objectForKey("user") as! NSDictionary
            let num : String = (item.objectForKey("number") as! NSNumber).stringValue
            if user.objectForKey("login")! as! String  == usuario{
                //dm.createPullRequest(num, projectName: path);
                //("PullRequest", name: item.objectForKey("number"))
                return true
            }
        }
        
        return false
    }
    
    func getPull(path:String, usuario:String)->String{
        
        var url = NSURL(string: "https://api.github.com/repos/\(path)/pulls?client_id=\(clientID)&client_secret=\(clientSecret)")
        
        
        var jsonData = NSData(contentsOfURL: url!)
        var jsonRes: AnyObject! = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        var resultado = jsonRes as! Array<NSDictionary>
        
        for item in resultado{
            let user = item.objectForKey("user") as! NSDictionary
            
            if user.objectForKey("login")! as! String  == usuario{
                let num : String = (item.objectForKey("number") as! NSNumber).stringValue
                return num
                //("PullRequest", name: item.objectForKey("number"))
            }
        }
        return ""
    }
    
    func getLabel(number:String, path:String){
        
        
        var url = NSURL(string: "https://api.github.com/repos/\(path)/issues/\(number)?client_id=\(clientID)&client_secret=\(clientSecret)")
        
        
        var resultado = self.getJSON(url!) as! NSDictionary
        
        
        var labels: AnyObject? = resultado.objectForKey("labels")
        let date: String? = resultado.objectForKey("updated_at") as? String
        
        var pull = dm.searchEntity("PullRequest", predicate: "number == \(number)") as! PullRequest
        pull.lastUpdate = date!
        dm.context?.save(nil);
        
        
        //fazer metodo no datamanager que recebe date, pull e verifica se atualiza
        
        println("eita cara olha essa data ----> \(date)")
        var lab = labels as! Array<NSDictionary>
        
        for item in lab{
            
            let color = item.objectForKey("color") as! String
            let name = item.objectForKey("name") as! String
            
            
            println("\(color),\(name)")
        }
    }
    
    func getJSON(url:NSURL)->AnyObject{
        var jsonData = NSData(contentsOfURL: url)
        return NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)!
    }
}
