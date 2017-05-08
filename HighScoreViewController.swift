//
//  HighScoreViewController.swift
//  Amino Acids
//
//  Created by Blake VanBerlo on 2016-10-29.
//  Copyright © 2016 VanBoss. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController {

    
    @IBOutlet weak var hsTable: UITableView!
    var highScores: [Int]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScoreDefault = NSUserDefaults.standardUserDefaults();
        
        if(highScoreDefault.valueForKey("high-scores") != nil)
        {
            highScores = highScoreDefault.valueForKey("high-scores") as! [Int]!;
            
        }
        
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
