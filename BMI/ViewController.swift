//
//  ViewController.swift
//  BMI
//
//  Created by Neil Houselander on 31/01/2016.
//  Copyright © 2016 Neil Houselander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var enterStoneTextField: UITextField!
    @IBOutlet weak var enterPoundsTextField: UITextField!
    @IBOutlet weak var enterheightFeatTextField: UITextField!
    @IBOutlet weak var enterHeightInchesTextField: UITextField!
    @IBOutlet weak var calculateBmiButtonOutlet: UIButton!
    @IBOutlet weak var yourBMILabel: UILabel!
    @IBOutlet weak var cheekyLabel: UILabel!
    @IBOutlet weak var resetButtonOutlet: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func calculateBmiButtonPressed(sender: UIButton) {
        
        //main error handling - empty boxes
        if self.enterStoneTextField.text == "" || self.enterPoundsTextField.text == "" || self.enterheightFeatTextField.text == "" || self.enterHeightInchesTextField.text == "" {
            self.hideKeyboard()
            self.yourBMILabel.text = "Fill In All The Boxes Please !"
            self.yourBMILabel.hidden = false
            self.resetButtonOutlet.hidden = false
            self.calculateBmiButtonOutlet.hidden = true
        }
            
        else {
            
         //grab weight
        let stoneWeight = Int(self.enterStoneTextField.text!)
        let llbsWeight = Int(self.enterPoundsTextField.text!)
        
        //grab height
        let feetHeight = Int(self.enterheightFeatTextField.text!)
        let inchHeight = Int(self.enterHeightInchesTextField.text!)
            
            //secondary error handling - nil values in case of a copy & pasted non number
            if stoneWeight == nil || llbsWeight == nil || feetHeight == nil || inchHeight == nil {
                self.yourBMILabel.text = "Numbers Only Please"
                self.yourBMILabel.hidden = false
                self.hideKeyboard()
                self.resetButtonOutlet.hidden = false
                self.calculateBmiButtonOutlet.hidden = true
            }
                
            else {
              
        //convert weight to kg
        let convertedWeightInKg = self.convertWeightToMetric(stone: stoneWeight!, lbs: llbsWeight!)
        print("converted weight in kg is \(convertedWeightInKg)")
        
        //convert height to metric
        let convertedHeightInMetric = self.convertHeightToMetric(ft: feetHeight!, inches: inchHeight!)
        print("converted height in metric is \(convertedHeightInMetric)")
      
        //do the calculation = (weight/height)/height
        let calculatedBmi = (convertedWeightInKg/convertedHeightInMetric)/convertedHeightInMetric
        print("BMI calc is " + String(format: "%.2f", calculatedBmi))
        
        //hide keyboard
        self.hideKeyboard()
        
        //output result to your BMI label
        self.yourBMILabel.text = "Your BMI is....." + String(format: "%.2f", calculatedBmi)
        
        //unhide BMI label
        self.yourBMILabel.hidden = false
        
        //use if or switch to output under/norm/over/obese & a cheeky comment
        // less than 18.5 = underweight
        //18.6 - 24.9 = healthy/normal
        //25 - 29.9 = overweight
        //30+ = obese
        if calculatedBmi <= 18.5 {
            self.cheekyLabel.text = "Underweight ! You need to get some burgers in you."
            
        }
            
        else if calculatedBmi >= 18.6 && calculatedBmi <= 24.9 {
            self.cheekyLabel.text = "Normal ! You are normal....ish."
           
        }
        
        else if calculatedBmi >= 25 && calculatedBmi <= 29.9 {
            self.cheekyLabel.text = "Overweight ! Who ate all the pies?......YOU DID!"
            
        }
            
        else {
            self.cheekyLabel.text = "OBESE ! Call a doctor or for gods sake STOP EATING!"
            
            
        }
        
        self.cheekyLabel.hidden = false
        
        //hide calculate button
        self.calculateBmiButtonOutlet.hidden = true
        
        //show reset button
        self.resetButtonOutlet.hidden = false
                
            }
        }
        
        
    }
    
    @IBAction func resetButtonPressed(sender: UIButton) {
        //clear all text fields
        self.enterStoneTextField.text = ""
        self.enterPoundsTextField.text = ""
        self.enterheightFeatTextField.text = ""
        self.enterHeightInchesTextField.text = ""
        
        
        //hide this button
        self.resetButtonOutlet.hidden = true
        
        //unhide calculate button
        self.calculateBmiButtonOutlet.hidden = false
        
        //hide bmi label
        self.yourBMILabel.hidden = true
        
        //hide cheekly label
        self.cheekyLabel.hidden = true
        
     
        
        
    //HELPER FUNCTIONS
        
    }
    
    func convertWeightToMetric (stone stone: Int, lbs: Int) -> Double {
        let weightStone = stone
        let weightPounds = lbs
        let combinedLbs = (weightStone * 14) + weightPounds
        let weightInKg = Double(combinedLbs)/2.2046
        return weightInKg
    }
    
    func convertHeightToMetric (ft ft: Int, inches: Int) -> Double {
        let heightFeet = ft
        let heightInches = inches
        let combinedHeightInInches = (heightFeet * 12) + heightInches
        let heightMetric = Double(combinedHeightInInches)/39.370
        return heightMetric
    }
    
    func hideKeyboard () {
        self.enterHeightInchesTextField.resignFirstResponder()
        self.enterStoneTextField.resignFirstResponder()
        self.enterPoundsTextField.resignFirstResponder()
        self.enterheightFeatTextField.resignFirstResponder()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

