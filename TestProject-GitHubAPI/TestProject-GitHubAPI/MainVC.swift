//
//  MainVC.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit
import Whisper

class MainVC: UIViewController, UITextFieldDelegate {

    var keyBoardHeight : CGFloat!
    var animationDistance : CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainVC.keyboardShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainVC.keyboardHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        inputTextField.delegate = self
        
        //set BarButton image
        let button = UIButton(type: .Custom)
        button.setImage(UIImage(named: "icon"), forState: UIControlState.Normal)
        button.addTarget(self, action:nil, forControlEvents: UIControlEvents.TouchDragInside)
        button.frame=CGRectMake(0, 0, 30, 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    // MARK: - Button
    @IBAction func buttonClick(sender: UIButton) {
        if !WebManager.isConnectedToNetwork() {
            showAlert("No internet connection", color: UIColor.redColor())
            return
        }
        if (inputTextField.text == "") {
            showAlert("Text field is empty", color: UIColor.grayColor())
        }
    }
    
    // MARK: - Show alert
    func showAlert(text : String, color : UIColor) {
        let message = Message(title: text, backgroundColor: color)
        // Show and hide a message after delay
        Whisper(message, to: navigationController!, action: .Show)
        // Present a permanent message
        Whisper(message, to: navigationController!, action: .Present)
        // Hide a message
        Silent(navigationController!)
    }
    
    // MARK: - KeyBoard
    func keyboardShown(notification: NSNotification) {
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        
        let rawFrame = value.CGRectValue
        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        keyBoardHeight = keyboardFrame.size.height
        if inputTextField.center.y + 24 > view.frame.size.height - keyBoardHeight{
            animateViewMoving(true, moveValue: inputTextField.center.y + 24 - (view.frame.size.height - keyBoardHeight))
            animationDistance = inputTextField.center.y + 24 - (view.frame.size.height - keyBoardHeight)
        }
    }
    
    func keyboardHide(notification: NSNotification) {
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        
        let rawFrame = value.CGRectValue
        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        keyBoardHeight = keyboardFrame.size.height
        if let distance = animationDistance {
            animateViewMoving(false, moveValue: distance)
        }
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }

    // MARK: - Textfield
    @IBOutlet weak var inputTextField: UITextField!
    func textFieldDidEndEditing(textField: UITextField) {
//        print("TextField did end editing method called")
//        if !(textField.text == nil) {
//            let defaults = NSUserDefaults.standardUserDefaults()
//            defaults.setObject(textField.text, forKey: memoreKey)
//            defaults.synchronize()
//            bottomState = .Registered
//        }
//        updateBottomButtons()
//        //animateViewMoving(false, moveValue: keyBoardHeight - 46)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
    

}
