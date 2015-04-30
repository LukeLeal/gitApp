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
        self.configureView()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        self.image1.layer.cornerRadius = 75.0
        self.image2.layer.cornerRadius = 75.0
        self.image3.layer.cornerRadius = 75.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

