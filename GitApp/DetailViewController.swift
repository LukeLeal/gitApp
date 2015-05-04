//
//  DetailViewController.swift
//  GitApp
//
//  Created by Felipe Marques Ramos on 27/04/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var dm = DataManager.sharedInstance
    var  proj : String?
    var contadorO : Int = 0
    var contadorP : Int = 0
    var contadorB : Int = 0
    var contadorI : Int = 0
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!

    
    @IBOutlet weak var ouro: UILabel!
    @IBOutlet weak var prata: UILabel!
    @IBOutlet weak var bronze: UILabel!

    
    @IBOutlet weak var problema: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(proj)
        
        let not = NSNotificationCenter.defaultCenter()
        not.addObserver(self, selector: "update:", name: "update", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Rewind , target: self, action: "goBack")
        
        
        self.image1.layer.cornerRadius = 60.0
        image1.layer.borderColor = UIColor( red: 70/255, green: 88/255, blue:110/255, alpha: 1.0 ).CGColor
        image1.layer.borderWidth = 1.0
        
        
        self.image2.layer.cornerRadius = 60.0
        image2.layer.borderColor = UIColor( red: 70/255, green: 88/255, blue:110/255, alpha: 1.0 ).CGColor
        image2.layer.borderWidth = 1.0
        
        
        self.image3.layer.cornerRadius = 60.0
        image3.layer.borderColor = UIColor( red: 70/255, green: 88/255, blue:110/255, alpha: 1.0 ).CGColor
        image3.layer.borderWidth = 1.0
        
        ouro.layer.cornerRadius = 8.0
        ouro.layer.borderColor = UIColor( red: 70/255, green: 88/255, blue:110/255, alpha: 1.0 ).CGColor
        ouro.layer.borderWidth = 1.0
        
        prata.layer.cornerRadius = 8.0
        prata.layer.borderColor = UIColor( red: 70/255, green: 88/255, blue:110/255, alpha: 1.0 ).CGColor
        prata.layer.borderWidth = 1.0
        
        bronze.layer.cornerRadius = 8.0
        bronze.layer.borderColor = UIColor( red: 70/255, green: 88/255, blue:110/255, alpha: 1.0 ).CGColor
        bronze.layer.borderWidth = 1.0
        
        problema.layer.cornerRadius = 8.0
        problema.layer.borderColor = UIColor( red: 70/255, green: 88/255, blue:110/255, alpha: 1.0 ).CGColor
        problema.layer.borderWidth = 1.0
        
       
        
        self.getLabels()
        
        
        
       
        
        
        
    }
    
    func goBack(){
//        self.navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func update(not: NSNotification){
        let userInfo = not.userInfo as! Dictionary<String,String>
        let repo = userInfo["repo"]
        println(repo!)
    }
    
    
    func getLabels(){
        var ud = NSUserDefaults.standardUserDefaults();
        var user = ud.valueForKey("usuario") as! String;
        var pr = dm.searchEntity("PullRequest", predicate: "project.name = '\(proj!)' AND owner == '\(user)'") as! PullRequest
        //pegar as labels do pull request
//        var cor = dm.searchEntity("color")
//        var nome = dm.searchEntity("name")
        var labels : NSArray = NSArray(array: pr.labels.allObjects);
       println("Eita olha as cores")
        println(labels)
        
        for label in labels{
            if(label.type == "B"){//bronze
                contadorB++
                bronze.text = NSString(format:"%d", contadorB) as String
            }
            else if(label.type == "a"){//prata
                contadorP++
                prata.text = NSString(format:"%d", contadorP) as String
            }
            else if(label.type == "O"){//ouro
                contadorO++
                ouro.text = NSString(format:"%d", contadorO) as String
            }
            else{//problema
                contadorI++
                problema.text = NSString(format:"%d", contadorI) as String
                
            }
            
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

