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
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
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
    @IBOutlet weak var progressView: UIProgressView!
    
    var aa: [AminoAcid]!
    var done: [Int]!
    var curAa: AminoAcid!
    var curTextField: UITextField!
    var attempts: Int!
    var score: Int!
    var numAminoAcids: Int!
    var knownEntity: Int!
    var correctImg: Int!
    var selectedImg: Int!
    var randomKnown: Bool!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Initialization of class variables
        aa = [AminoAcid]();
        done = [Int]();
        attempts = 0;
        score = 0;
        numAminoAcids = 0;
        correctImg = 1;
        selectedImg = 0;
        randomKnown = false;
        
        // Finishing up UI setup
        self.view.backgroundColor = UIColor(red: 123.0/256.0, green: 224.4/256.0, blue: 172.0/256.0, alpha: 1.0);
        nameText.backgroundColor = UIColor(red: 193.0/256.0, green: 255.4/256.0, blue: 231.0/256.0, alpha: 1.0);
        abb3Text.backgroundColor = UIColor(red: 193.0/256.0, green: 255.4/256.0, blue: 231.0/256.0, alpha: 1.0);
        abb1Text.backgroundColor = UIColor(red: 193.0/256.0, green: 255.4/256.0, blue: 231.0/256.0, alpha: 1.0);
        classificationButton.backgroundColor = UIColor(red: 193.0/256.0, green: 255.4/256.0, blue: 231.0/256.0, alpha: 1.0);
        ahoi.contentMode = UIViewContentMode.ScaleAspectFit;
        ahoi.clipsToBounds = true;
        img1.contentMode = UIViewContentMode.ScaleAspectFit;
        img1.clipsToBounds = true;
        img2.contentMode = UIViewContentMode.ScaleAspectFit;
        img2.clipsToBounds = true;
        img3.contentMode = UIViewContentMode.ScaleAspectFit;
        img3.clipsToBounds = true;
        img4.contentMode = UIViewContentMode.ScaleAspectFit;
        img4.clipsToBounds = true;
        classificationButton.layer.borderColor = UIColor.blackColor().CGColor;
        classificationButton.layer.cornerRadius = 5.0;
        classificationButton.titleLabel?.numberOfLines = 2;
        img1.layer.borderWidth = 3.0;
        img2.layer.borderWidth = 3.0;
        img3.layer.borderWidth = 3.0;
        img4.layer.borderWidth = 3.0;
        ahoi.layer.borderWidth = 3.0;
        img1.layer.borderColor = UIColor.blackColor().CGColor;
        img2.layer.borderColor = UIColor.blackColor().CGColor;
        img3.layer.borderColor = UIColor.blackColor().CGColor;
        img4.layer.borderColor = UIColor.blackColor().CGColor;
        ahoi.layer.borderColor = UIColor.blackColor().CGColor;
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController2.dismissKeyboard));
        self.view.addGestureRecognizer(tap);
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(ViewController2.tapImg1));
        img1.addGestureRecognizer(tap1);
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(ViewController2.tapImg2));
        img2.addGestureRecognizer(tap2);
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(ViewController2.tapImg3));
        img3.addGestureRecognizer(tap3);
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(ViewController2.tapImg4));
        img4.addGestureRecognizer(tap4);
        
        // Get known value from settings
        let settingsDefault = NSUserDefaults.standardUserDefaults()
        var known = settingsDefault.valueForKey("settings-known-attribute") as! Int!;
        if(known == nil)
        {
            settingsDefault.setValue(0, forKey: "settings-known-attribute");
        }
        known = settingsDefault.valueForKey("settings-known-attribute") as! Int!;
        knownEntity = known;
        if(knownEntity == 4)
        {
            randomKnown = true;
        }
        
        
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
        progressView.setProgress(Float(done.count)/20.0, animated: true)
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
        img1.layer.borderColor = UIColor.blackColor().CGColor;
        img2.layer.borderColor = UIColor.blackColor().CGColor;
        img3.layer.borderColor = UIColor.blackColor().CGColor;
        img4.layer.borderColor = UIColor.blackColor().CGColor;
        
        // Add this question to the list of questions that are done.
        var ind:Int = -1;
        repeat
        {
            ind = Int(arc4random_uniform((UInt32)(aa.count)));
        }while(done.contains(ind) == true)
        done.append(ind);
        curAa = aa[ind];
        
        // Set known value
        nameText.userInteractionEnabled = true;
        abb3Text.userInteractionEnabled = true;
        abb1Text.userInteractionEnabled = true;
        if(randomKnown == true)
        {
            knownEntity = Int(arc4random_uniform((UInt32)(4)));
        }
        
        // Set known entity.
        switch knownEntity
        {
        case 0:
            let image : UIImage? = UIImage(named: curAa.imageStr)!;
            ahoi.image = image;
            img1.hidden = true;
            img2.hidden = true;
            img3.hidden = true;
            img4.hidden = true;
            ahoi.hidden = false;
        case 1:
            nameText.text = curAa.name;
            nameText.userInteractionEnabled = false;
            img1.hidden = false;
            img2.hidden = false;
            img3.hidden = false;
            img4.hidden = false;
            ahoi.hidden = true;
        case 2:
            abb3Text.text = curAa.abb3Ltr;
            abb3Text.userInteractionEnabled = false;
            img1.hidden = false;
            img2.hidden = false;
            img3.hidden = false;
            img4.hidden = false;
            ahoi.hidden = true;
        case 3:
            abb1Text.text = curAa.abb1Ltr;
            abb1Text.userInteractionEnabled = false;
            img1.hidden = false;
            img2.hidden = false;
            img3.hidden = false;
            img4.hidden = false;
            ahoi.hidden = true;
        default:
            let image : UIImage? = UIImage(named: curAa.imageStr)!;
            ahoi.image = image;
            nameText.userInteractionEnabled = true;
            abb3Text.userInteractionEnabled = true;
            abb1Text.userInteractionEnabled = true;
            img1.hidden = true;
            img2.hidden = true;
            img3.hidden = true;
            img4.hidden = true;
            ahoi.hidden = false;
        }
        
        // Set new image alternatives.
        if(knownEntity != 0)
        {
            correctImg = Int(arc4random_uniform((UInt32)(4)));
            var imgInd1 = 0, imgInd2 = 0, imgInd3 = 0, imgInd4 = 0;
            if(correctImg == 0){
                let image1 : UIImage? = UIImage(named: curAa.imageStr)!;
                img1.image = image1;
                imgInd1 = ind;
                repeat
                {
                    imgInd2 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd2 == imgInd1);
                repeat
                {
                    imgInd3 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd3 == imgInd1 && imgInd3 == imgInd2);
                repeat
                {
                    imgInd4 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd4 == imgInd1 && imgInd4 == imgInd2 && imgInd4 == imgInd3);
                img2.image = UIImage(named: aa[imgInd2].imageStr)!;
                img3.image = UIImage(named: aa[imgInd3].imageStr)!;
                img4.image = UIImage(named: aa[imgInd4].imageStr)!;
            }
            else if(correctImg == 1){
                let image2 : UIImage? = UIImage(named: curAa.imageStr)!;
                img2.image = image2;
                imgInd2 = ind;
                repeat
                {
                    imgInd1 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd1 == imgInd2);
                repeat
                {
                    imgInd3 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd3 == imgInd1 && imgInd3 == imgInd2);
                repeat
                {
                    imgInd4 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd4 == imgInd1 && imgInd4 == imgInd2 && imgInd4 == imgInd3);
                img1.image = UIImage(named: aa[imgInd1].imageStr)!;
                img3.image = UIImage(named: aa[imgInd3].imageStr)!;
                img4.image = UIImage(named: aa[imgInd4].imageStr)!;
            }
            else if(correctImg == 2){
                let image3 : UIImage? = UIImage(named: curAa.imageStr)!;
                img3.image = image3;
                imgInd3 = ind;
                repeat
                {
                    imgInd1 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd1 == imgInd3);
                repeat
                {
                    imgInd2 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd3 == imgInd1 && imgInd3 == imgInd2);
                repeat
                {
                    imgInd4 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd4 == imgInd1 && imgInd4 == imgInd2 && imgInd4 == imgInd3);
                img1.image = UIImage(named: aa[imgInd1].imageStr)!;
                img2.image = UIImage(named: aa[imgInd2].imageStr)!;
                img4.image = UIImage(named: aa[imgInd4].imageStr)!;
            }
            else if(correctImg == 3){
                let image4 : UIImage? = UIImage(named: curAa.imageStr)!;
                img4.image = image4;
                imgInd4 = ind;
                repeat
                {
                    imgInd1 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd1 == imgInd4);
                repeat
                {
                    imgInd2 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd4 == imgInd1 && imgInd4 == imgInd2);
                repeat
                {
                    imgInd3 = Int(arc4random_uniform((UInt32)(aa.count)));
                }while(imgInd4 == imgInd1 && imgInd4 == imgInd2 && imgInd4 == imgInd3);
                img1.image = UIImage(named: aa[imgInd1].imageStr)!;
                img2.image = UIImage(named: aa[imgInd2].imageStr)!;
                img3.image = UIImage(named: aa[imgInd3].imageStr)!;
            }
        }
        
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
            if(knownEntity != 0) // Determine if user selected correct image and reset border colours.
            {
                if(correctImg == selectedImg) // User selected correct image.
                {
                    score = score + 1; // Increment score.
                    scoreLabel.text = "SCORE: " + String.init(stringInterpolationSegment: score);
                    if(correctImg == 0){
                        img1.layer.borderColor = UIColor.greenColor().CGColor;
                    }
                    else if(correctImg == 1){
                        img2.layer.borderColor = UIColor.greenColor().CGColor;
                    }
                    else if(correctImg == 2){
                        img3.layer.borderColor = UIColor.greenColor().CGColor;
                    }
                    else if(correctImg == 3){
                        img4.layer.borderColor = UIColor.greenColor().CGColor;
                    }
                }
                else
                {
                    if(correctImg == 0){
                        img1.layer.borderColor = UIColor.redColor().CGColor;
                    }
                    else if(correctImg == 1){
                        img2.layer.borderColor = UIColor.redColor().CGColor;
                    }
                    else if(correctImg == 2){
                        img3.layer.borderColor = UIColor.redColor().CGColor;
                    }
                    else if(correctImg == 3){
                        img4.layer.borderColor = UIColor.redColor().CGColor;
                    }
                }
            }
            if(knownEntity != 1) // Determine if user selected correct name.
            {
                if(nameText.text?.uppercaseString == curAa.name.uppercaseString)
                {
                    nameText.backgroundColor = UIColor.greenColor();
                    score = score + 1; // Increment score if they got name right on first try.
                    scoreLabel.text = "SCORE: " + String.init(stringInterpolationSegment: score);
                
                }
                else{
                    nameText.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 0, blue: 0, alpha: 0.7);
                }
            }
            if(knownEntity != 2) // Determine if user selected correct 3-letter abbreviation.
            {
                if(abb3Text.text?.uppercaseString == curAa.abb3Ltr.uppercaseString)
                {
                    abb3Text.backgroundColor = UIColor.greenColor();
                    score = score + 1; // Increment score if they got 3-letter abbreviation right on first try.
                    scoreLabel.text = "SCORE: " + String.init(stringInterpolationSegment: score);
                
                }
                else{
                    abb3Text.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 0, blue: 0, alpha: 0.7);
                }
            }
            if(knownEntity != 3) // Determine if user selected correct 1-letter abbreviation.
            {
                if(abb1Text.text?.uppercaseString == curAa.abb1Ltr.uppercaseString)
                {
                    abb1Text.backgroundColor = UIColor.greenColor();
                    score = score + 1; // Increment score if they got 1-letter abbreviation right on first try.
                    scoreLabel.text = "SCORE: " + String.init(stringInterpolationSegment: score);
                
                }
                else{
                    abb1Text.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 0, blue: 0, alpha: 0.7);
                }
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
    
    /*---------------------------------------------------------------------------------------------
    Event handlers that highlight an image when tapped.  Implemented for image alternatives 1-4.
    */
    func tapImg1()
    {
        img1.layer.borderColor = UIColor.blueColor().CGColor;
        img2.layer.borderColor = UIColor.blackColor().CGColor;
        img3.layer.borderColor = UIColor.blackColor().CGColor;
        img4.layer.borderColor = UIColor.blackColor().CGColor;
        selectedImg = 0;
    }
    
    func tapImg2()
    {
        img1.layer.borderColor = UIColor.blackColor().CGColor;
        img2.layer.borderColor = UIColor.blueColor().CGColor;
        img3.layer.borderColor = UIColor.blackColor().CGColor;
        img4.layer.borderColor = UIColor.blackColor().CGColor;
        selectedImg = 1;
    }
    
    func tapImg3()
    {
        img1.layer.borderColor = UIColor.blackColor().CGColor;
        img2.layer.borderColor = UIColor.blackColor().CGColor;
        img3.layer.borderColor = UIColor.blueColor().CGColor;
        img4.layer.borderColor = UIColor.blackColor().CGColor;
        selectedImg = 2;
    }
    
    func tapImg4()
    {
        img1.layer.borderColor = UIColor.blackColor().CGColor;
        img2.layer.borderColor = UIColor.blackColor().CGColor;
        img3.layer.borderColor = UIColor.blackColor().CGColor;
        img4.layer.borderColor = UIColor.blueColor().CGColor;
        selectedImg = 3;
    }
    /*------------------------------------------------------------------------------------------*/
    
    
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
