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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
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
    alert.title = "No Text"
    alert.message = "Please Enter Text In The Box"
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
