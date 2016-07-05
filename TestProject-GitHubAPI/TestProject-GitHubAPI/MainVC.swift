//
//  MainVC.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITextFieldDelegate {

    var keyBoardHeight : CGFloat!
    var animationDistance : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainVC.keyboardShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainVC.keyboardHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
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
        animateViewMoving(false, moveValue: animationDistance)
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
//        print("TextField should return method called")
//        textField.resignFirstResponder();
        return true;
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
    

}
