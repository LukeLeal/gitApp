//
//  jSONManager.swift
//  GitApp
//
//  Created by Felipe Marques Ramos on 29/04/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import UIKit

class jSONManager: NSObject {
    func buscarRepos(user:String!){
        let clientID = "8fb09c4abdef8660c7a4"
        let clientSecret = "562c127dd23de151e09483cea87b0e64ab58514c"
        
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
                repos.append(repo)
            }
        }
    }
    
    func verificarPulls(usuario:String, path:String)->Bool{
        let clientID = "8fb09c4abdef8660c7a4"
        let clientSecret = "562c127dd23de151e09483cea87b0e64ab58514c"
        
        var url = NSURL(string: "https://api.github.com/repos/\(path)/pulls?client_id=\(clientID)&client_secret=\(clientSecret)")
        
        
        var jsonData = NSData(contentsOfURL: url!)
        var jsonRes: AnyObject! = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        var resultado = jsonRes as! Array<NSDictionary>
        
        //        var tdsRepos = Array<String>()
        
        for item in resultado{
            let user = item.objectForKey("user") as! NSDictionary
            if user.objectForKey("login")! as! String  == usuario{
                return true
            }
        }
        
        return false
    }
}
