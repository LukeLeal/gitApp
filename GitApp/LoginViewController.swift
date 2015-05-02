//
//  LoginViewController.swift
//  GitApp
//
//  Created by Lucas Leal Mendonça on 30/04/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var user: UILabel!
    
    @IBOutlet weak var signin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.view.backgroundColor = UIColor.whiteColor()    
        
    
        
        user.layer.cornerRadius = 8.0
//        unametxt.layer.masksToBounds = true
        user.layer.borderColor = UIColor( red: 70/255, green: 88/255, blue:110/255, alpha: 1.0 ).CGColor
        user.layer.borderWidth = 1.0
        
        signin.layer.cornerRadius = 8.0
        signin.layer.borderColor = UIColor( red: 70/255, green: 88/255, blue:110/255, alpha: 1.0 ).CGColor
        signin.layer.borderWidth = 1.0
//        signin.backgroundColor = UIColor.greenColor()
        loginField.layer.cornerRadius = 8.0
        loginField.layer.borderColor = UIColor( red: 70/255, green: 88/255, blue:110/255, alpha: 1.0 ).CGColor
        loginField.layer.borderWidth = 1.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Button(sender: UIButton) {
        
        
        
        var ud : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        ud.setValue(loginField.text, forKeyPath: "usuario")
        
        println(ud.valueForKey("usuario"))
        
        
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        
        
        if identifier == "segueTest" {
            
            if (loginField.text.isEmpty) {
                
                let alert = UIAlertView()
                alert.title = "Sem texto"
                alert.message = "Digite o nome do usuario Git"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
                
            }
                
            else {
                
                return true
            }
        }
        
        // by default, transition
        return true
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
