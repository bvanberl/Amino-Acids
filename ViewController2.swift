//
//  ViewController2.swift
//  Amino Acids
//
//  Created by Blake VanBerlo on 2016-05-27.
//  Copyright © 2016 VanBoss. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITextFieldDelegate, UIActionSheetDelegate {
    
    //MARK: Properties
    @IBOutlet weak var ahoi: UIImageView!
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var abb3Text: UITextField!
    @IBOutlet weak var abb1Text: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abb3Label: UILabel!
    @IBOutlet weak var abb1Label: UILabel!
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var classificationButton: UIButton!
    
    var aa: [AminoAcid]!
    var done: [Int]!
    var curAa: AminoAcid!
    var curTextField: UITextField!
    var attempts: Int!
    var score: Int!
    var numAminoAcids: Int!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Initialization of class variables
        aa = [AminoAcid]();
        done = [Int]();
        attempts = 0;
        score = 0;
        numAminoAcids = 0;
        
        // Finishing up UI setup
        self.view.backgroundColor = UIColor(red: 123.0/256.0, green: 224.4/256.0, blue: 172.0/256.0, alpha: 1.0);
        nameText.backgroundColor = UIColor(red: 193.0/256.0, green: 255.4/256.0, blue: 231.0/256.0, alpha: 1.0);
        abb3Text.backgroundColor = UIColor(red: 193.0/256.0, green: 255.4/256.0, blue: 231.0/256.0, alpha: 1.0);
        abb1Text.backgroundColor = UIColor(red: 193.0/256.0, green: 255.4/256.0, blue: 231.0/256.0, alpha: 1.0);
        classificationButton.backgroundColor = UIColor(red: 193.0/256.0, green: 255.4/256.0, blue: 231.0/256.0, alpha: 1.0);
        ahoi.contentMode = UIViewContentMode.ScaleAspectFit;
        ahoi.clipsToBounds = true;
        classificationButton.layer.borderColor = UIColor.blackColor().CGColor;
        classificationButton.layer.cornerRadius = 5.0;
        classificationButton.titleLabel?.numberOfLines = 2;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard");
        self.view.addGestureRecognizer(tap);
        
        
        // Read content of amino acids lookup table (in text format).
        var lines:[String] = [String]();
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "txt")
        let contents: NSString
        do {
            contents = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        } catch _ {
            contents = ""
        }
        lines = contents.componentsSeparatedByString("\n");
        
        // Create amino acid objects.
        for i in 0...lines.count - 1
        {
            var details:[String] = lines[i].componentsSeparatedByString(",");
            aa.append(AminoAcid(nam:details[0], filename:details[1], ltr3:details[2], ltr1:details[3], clsn:details[4]));
        }
        numAminoAcids = lines.count;
    
        setUpNextQuestion(); // Prepare first question
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // UITextField Delegates------------------
    func textFieldDidBeginEditing(textField: UITextField) {
        scrollView.setContentOffset(CGPointMake(0, 125), animated: true);
        curTextField = textField;
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        curTextField.endEditing(true);
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true);
        return true;
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    //-----------------------------------------
    
    
    // Set up UI for next question.
    func setUpNextQuestion()
    {
        // If 20 questions have been answered, the game is over.
        if(done.count >= numAminoAcids)
        {
            submitButton.enabled = false;
            attempts = 0;
            done.removeAll();
            self.performSegueWithIdentifier("game_over", sender: score); // Perform segue
            return;
        }
        
        // Clear input fields and set to appropriate colour.
        nameText.backgroundColor = UIColor.whiteColor();
        abb3Text.backgroundColor = UIColor.whiteColor();
        abb1Text.backgroundColor = UIColor.whiteColor();
        nameText.text = "";
        abb3Text.text = "";
        abb1Text.text = "";
        classificationButton.setTitle("Tap to select...", forState: UIControlState.Normal);
        classificationButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal);
        classificationButton.backgroundColor = UIColor.whiteColor();
        
        // Add this question to the list of questions that are done.
        var index:Int = -1;
        repeat
        {
            index = Int(arc4random_uniform((UInt32)(aa.count)));
        }while(done.contains(index) == true)
        done.append(index);
        curAa = aa[index];
        let image : UIImage? = UIImage(named: curAa.imageStr)!;
        ahoi.image = image;
        questionCountLabel.text = "Question " + String.init(stringInterpolationSegment: done.count) + " of 20";
        
    }
    
    // Update choice of classification of amino acid
    func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int)
    {
        switch buttonIndex{
            case 0:
                classificationButton.setTitle("Polar\n" +
                    "Acidic", forState: UIControlState.Normal);
                break;
            case 1:
                classificationButton.setTitle("Polar\n" +
                    "Basic", forState: UIControlState.Normal);
                break;
            case 2:
                classificationButton.setTitle("Nonpolar\n" +
                    "Hydrophobic", forState: UIControlState.Normal);
                break;
            case 3:
                classificationButton.setTitle("Polar\n" +
                    "Neutral", forState: UIControlState.Normal);
                break;
            default:
                classificationButton.setTitle("Tap to select...", forState: UIControlState.Normal);
                break;
        }
        classificationButton.titleLabel?.textColor = UIColor.blackColor();
    }
    
    
    // MARK: Actions
    @IBAction func on_Submit_Button_Pressed(sender: UIButton) {

        if(curTextField != nil) // Hide keyboard if it is visible
        {
            curTextField.endEditing(true);
            scrollView.setContentOffset(CGPointMake(0, 0), animated: true);
        }
        
        if(submitButton.titleLabel?.text == "NEXT")
        {
            setUpNextQuestion();
            submitButton.setTitle("SUBMIT", forState: UIControlState.Normal);
            return;
        }
        else {
            if(nameText.text?.uppercaseString == curAa.name.uppercaseString)
            {
                nameText.backgroundColor = UIColor.greenColor();
                score = score + 1; // Increment score if they got name right on first try.
                scoreLabel.text = "SCORE: " + String.init(stringInterpolationSegment: score);
                
            }
            else{
                nameText.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 0, blue: 0, alpha: 0.7);
            }
            if(abb3Text.text?.uppercaseString == curAa.abb3Ltr.uppercaseString)
            {
                abb3Text.backgroundColor = UIColor.greenColor();
                score = score + 1; // Increment score if they got 3-letter abbreviation right on first try.
                scoreLabel.text = "SCORE: " + String.init(stringInterpolationSegment: score);
                
            }
            else{
                abb3Text.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 0, blue: 0, alpha: 0.7);
            }
            if(abb1Text.text?.uppercaseString == curAa.abb1Ltr.uppercaseString)
            {
                abb1Text.backgroundColor = UIColor.greenColor();
                score = score + 1; // Increment score if they got 1-letter abbreviation right on first try.
                scoreLabel.text = "SCORE: " + String.init(stringInterpolationSegment: score);
                
            }
            else{
                abb1Text.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 0, blue: 0, alpha: 0.7);
            }
            if(classificationButton.titleLabel?.text!.stringByReplacingOccurrencesOfString("\n", withString: " ") == curAa.classification)
            {
                classificationButton.backgroundColor = UIColor.greenColor();
                score = score + 1; // Increment score if they got classification right on first try.
                scoreLabel.text = "SCORE: " + String.init(stringInterpolationSegment: score);
                
            }
            else{
                classificationButton.setTitle(curAa.classification.stringByReplacingOccurrencesOfString(" ", withString: "\n"), forState: UIControlState.Normal);
                classificationButton.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 0, blue: 0, alpha: 0.7);
            }
            classificationButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);

            // Display answers.
            submitButton.setTitle("NEXT", forState: UIControlState.Normal);
            nameText.text = curAa.name;
            abb3Text.text = curAa.abb3Ltr;
            abb1Text.text = curAa.abb1Ltr;
        }
    }
    
    
    // Display action bar to choose amino acid classification.
    @IBAction func action_sheet_button_pressed(sender: UIButton, forEvent event: UIEvent) {
        let actionSheet = UIActionSheet(title: "Classification Selection", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "Polar Acidic", "Polar Basic", "Nonpolar Hydrophobic", "Polar Neutral");
        actionSheet.showInView(self.view);
    }
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
     // MARK: - Navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "game_over")
        {
            let DestViewController = (segue.destinationViewController as! GameOverViewController);
            DestViewController.finScore = sender as! Int;
        }
     }

}
