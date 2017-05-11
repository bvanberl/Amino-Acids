//
//  SettingsViewController.swift
//  Amino Acids
//
//  Created by Blake VanBerlo on 2017-05-09.
//  Copyright © 2017 VanBoss. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var knownPickerView: UIPickerView!
    var options: [String] = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 123.0/256.0, green: 224.4/256.0, blue: 172.0/256.0, alpha: 1.0);
        self.knownPickerView.delegate = self;
        self.knownPickerView.dataSource = self;
        options = ["Diagram", "Name", "3-letter Abbreviation", "1-letter Abbreviation", "Random"];
        
        // Get known value from settings
        let settingsDefault = NSUserDefaults.standardUserDefaults()
        var known = settingsDefault.valueForKey("settings-known-attribute") as! Int!;
        if(known == nil)
        {
            settingsDefault.setValue(0, forKey: "settings-known-attribute");
        }
        known = settingsDefault.valueForKey("settings-known-attribute") as! Int!;
        knownPickerView.selectRow(known, inComponent: 0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Required method for UIPickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Required method for UIPickerView
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count;
    }
    
    // Required method for UIPickerView
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    // Required method for UIPickerView
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let settingsDefault = NSUserDefaults.standardUserDefaults();
        settingsDefault.setValue(row, forKey: "settings-known-attribute"); // Save chosen settings
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
