//
//  ViewController.swift
//  Amino Acids
//
//  Created by Blake VanBerlo on 2016-05-27.
//  Copyright © 2016 VanBoss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var high_score_label: UILabel!
    @IBOutlet weak var main_img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Finish setting up UI
        self.view.backgroundColor = UIColor(red: 123.0/256.0, green: 224.4/256.0, blue: 172.0/256.0, alpha: 1.0);
        let image : UIImage? = UIImage(named: "main.jpg")!;
        main_img.image = image;
        main_img.layer.borderWidth = 3.0;
        main_img.layer.borderColor = UIColor.blackColor().CGColor;
        
        let highScoreDefault = NSUserDefaults.standardUserDefaults();
        
        if(highScoreDefault.valueForKey("high-scores") != nil)
        {
            high_score_label.text = "Your High Score: " + String.init(stringInterpolationSegment: highScoreDefault.valueForKey("high-scores") as! Int!);
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

