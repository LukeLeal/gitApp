//
//  DetailViewController.swift
//  GitApp
//
//  Created by Felipe Marques Ramos on 27/04/15.
//  Copyright (c) 2015 Felipe Marques Ramos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!

    
    @IBOutlet weak var ouro: UILabel!
    @IBOutlet weak var prata: UILabel!
    
    @IBOutlet weak var bronze: UILabel!
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.valueForKey("timeStamp")!.description
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.configureView()
        self.view.backgroundColor = UIColor.whiteColor()
        
        
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
        
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

