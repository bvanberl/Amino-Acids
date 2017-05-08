//
//  GameOverViewController.swift
//  Amino Acids
//
//  Created by Blake VanBerlo on 2016-07-07.
//  Copyright © 2016 VanBoss. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var beatHighScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var finScore: Int!
    var highScore: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 123.0/256.0, green: 224.4/256.0, blue: 172.0/256.0, alpha: 1.0);
        
        scoreLabel.text = "Final Score: " + String.init(stringInterpolationSegment: finScore!);
        print(finScore!)
        let highScoreDefault = NSUserDefaults.standardUserDefaults()
        //if(highScoreDefault.valueForKey("high-scores") != nil)
        
            highScore = highScoreDefault.valueForKey("high-scores") as! Int!;
            if(highScore == nil)
            {
                highScoreDefault.setValue(finScore, forKey: "high-scores");
            }
            else if(highScore < finScore)
            {
                highScoreDefault.setValue(finScore, forKey: "high-scores");
                beatHighScoreLabel.text = "You beat your high score!";
            }
            highScore = highScoreDefault.valueForKey("high-scores") as! Int!;
            highScoreLabel.text = "Your High Score: " + String.init(stringInterpolationSegment: highScore);
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
