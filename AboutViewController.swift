//
//  AboutViewController.swift
//  Amino Acids
//
//  Created by Blake VanBerlo on 2017-01-17.
//  Copyright © 2017 VanBoss. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Finish setting up UI.
        self.view.backgroundColor = UIColor(red: 123.0/256.0, green: 224.4/256.0, blue: 172.0/256.0, alpha: 1.0);
        textView.editable = false;
        textView.showsVerticalScrollIndicator = true;
        textView.scrollEnabled = true;
        textView.layer.borderWidth = 1.5;
        textView.layer.borderColor = UIColor.blackColor().CGColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
