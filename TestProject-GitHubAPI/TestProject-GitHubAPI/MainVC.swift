//
//  MainVC.swift
//  TestProject-GitHubAPI
//
//  Created by Yura Chukhlib on 05.07.16.
//  Copyright © 2016 Yuri Chukhlib. All rights reserved.
//

import UIKit
import Whisper
import NVActivityIndicatorView

class MainVC: UIViewController, UITextFieldDelegate {

    var keyBoardHeight : CGFloat!
    var animationDistance : CGFloat!
    var indicator : NVActivityIndicatorView!
    
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
        
        indicator = NVActivityIndicatorView(frame: CGRectMake(view.frame.size.width / 2 - 30, view.frame.size.height / 2 , 60, 60), type: .Pacman, color: UIColor.redColor(), padding: 0)
        view.addSubview(indicator)
    }
    
    // MARK: - Button
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func buttonClick(sender: UIButton) {
        if (inputTextField.text == "") {
            showAlert("Text field is empty", color: UIColor.grayColor())
            return
        }
        
        if let user = DataManager.returnUserById(inputTextField.text!) {
            performSegueWithIdentifier("mainToDetail", sender: user)
        } else{
            if !WebManager.isConnectedToNetwork() {
                showAlert("No internet connection", color: UIColor.redColor())
                return
            }
            indicator.startAnimation()
            WebManager.getUserById(inputTextField.text!, completion: { (user) in
                self.indicator.stopAnimation()
                if user != nil {
                    self.performSegueWithIdentifier("mainToDetail", sender: user)
                } else {
                    self.showAlert("This user doesn't exist", color: UIColor.redColor())
                }
            })
        }
        
    }
    
    // MARK: - Alert
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
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mainToDetail" {
            if let destinationVC = segue.destinationViewController as? DetailVC {
                destinationVC.currentUser = sender as! User
            }
        }
    }

}
