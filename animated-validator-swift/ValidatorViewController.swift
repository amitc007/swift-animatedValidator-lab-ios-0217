//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!

    //
    enum FLD:Int { case EMAIL = 0, EMAILCONFIRM, PHONE, PASSWORD, PASSCONFIRM ,SUBMIT }
    var status:[Int] = Array(repeatElement(0, count: 5))

    func showError(_ tag:Int) {
        
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = FLT_MAX
        
        switch tag {
        case FLD.EMAIL.rawValue:
            emailTextField.layer.add(pulseAnimation, forKey: "animateOpacity")
            emailTextField.backgroundColor = UIColor.red
        case FLD.EMAILCONFIRM.rawValue:
            emailConfirmationTextField.layer.add(pulseAnimation, forKey: "animateOpacity")
            emailConfirmationTextField.backgroundColor = UIColor.red
        case FLD.PHONE.rawValue:
            phoneTextField.layer.add(pulseAnimation, forKey: "animateOpacity")
            phoneTextField.backgroundColor = UIColor.red
        case FLD.PASSWORD.rawValue:
            passwordTextField.layer.add(pulseAnimation, forKey: "animateOpacity")
            passwordTextField.backgroundColor = UIColor.red
        case FLD.PASSCONFIRM.rawValue:
            passwordConfirmTextField.layer.add(pulseAnimation, forKey: "animateOpacity")
            passwordConfirmTextField.backgroundColor = UIColor.red
            
        case FLD.SUBMIT.rawValue:
            submitButton.isEnabled = true
            submitButton.layer.add(pulseAnimation, forKey: "animateOpacity")
            submitButton.backgroundColor = UIColor.blue

        default:
            break
        }
        //self.view.layer.add(pulseAnimation, forKey: "animateOpacity")
    }
  
    //check Status
    func checkStatus() {
        for val in  status {
            if val == 0 { return  }
        }
        showError(FLD.SUBMIT.rawValue)   //this is not error but for status
    }
    

    @IBAction func editingEnded(_ sender: UITextField) {
        switch sender.tag {
        case FLD.EMAIL.rawValue:
            if let emailText = emailTextField.text {
                if !(emailText.contains("@")) || !(emailText.contains(".")) {
                    showError(FLD.EMAIL.rawValue) } else
                { status[FLD.EMAIL.rawValue] = 1  }
            }
            
        case FLD.EMAILCONFIRM.rawValue:
            if let emailText = emailTextField.text {
                if !(emailText.contains("@")) || !(emailText.contains(".")) {
                    showError(FLD.EMAILCONFIRM.rawValue) } else {
                    status[FLD.EMAILCONFIRM.rawValue] = 1
                }
            }
            
        case FLD.PHONE.rawValue:
            if let phone = phoneTextField.text {
                if phone.characters.count < 7 {   showError(FLD.PHONE.rawValue)     }
                for c in phone.characters {
                    if c < "0" || c > "9" {  showError(FLD.PHONE.rawValue) } else {
                        status[FLD.PHONE.rawValue] = 1
                    }
                }
            }
//        case FLD.SUBMIT.rawValue:
            
        case FLD.PASSWORD.rawValue:
            if let pass = passwordTextField.text {
                if pass.characters.count < 6 {  showError(FLD.PASSWORD.rawValue) } else {
                    status[FLD.PASSWORD.rawValue] = 1
                }
            }
        case FLD.PASSCONFIRM.rawValue:
            if let pass = passwordTextField.text {
                if pass.characters.count < 6 {  showError(FLD.PASSCONFIRM.rawValue) } else {
                    status[FLD.PASSCONFIRM.rawValue] = 1
                }
            }

        default:
            break
        }
        
        checkStatus()
        
    } //func
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        self.submitButton.isEnabled = false
    
        //init - assign number to fields
        emailTextField.tag = FLD.EMAIL.rawValue
        emailConfirmationTextField.tag = FLD.EMAILCONFIRM.rawValue
        phoneTextField.tag = FLD.PHONE.rawValue
        //submitButton.tag = FLD.SUBMIT.rawValue
        passwordTextField.tag = FLD.PASSWORD.rawValue
        passwordConfirmTextField.tag = FLD.PASSCONFIRM.rawValue
        
    }
    

}
