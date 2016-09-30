//
//  CityDetailsViewController.swift
//  WeatherWebService
//
//  Created by komal lunkad on 29/09/16.
//  Copyright © 2016 komal lunkad. All rights reserved.
//


import UIKit

class CityDetailsViewController: UIViewController {
    @IBOutlet var textFieldCityName: UITextField!
    var cityName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldCityName.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonCheckWeatherTapped(sender: AnyObject) {
        cityName = textFieldCityName.text
        if !isWhitespace(cityName!) {
            self.showAlertView(Constants.AlertViewMessages.alertViewTitle,alertMessage: Constants.AlertViewMessages.whiteSpaceMessage)
        }
        else if !isAlphabetic(cityName!) {
            self.showAlertView(Constants.AlertViewMessages.alertViewTitle,alertMessage: Constants.AlertViewMessages.onlyAlphabetMessage)
        }
        else{
            pushViewController()
        }
    }
    
    //MARK:IsWhitespace
    /** Checks whether the input is empty or not
     * param name: input string to be checked
     * returns false if empty string else returns true
     */
    func isWhitespace(name: String) -> Bool{
        let trimmedName:String = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if trimmedName.characters.count == 0 {
            return false
        }
        return true
    }
    
    //MARK:IsAlphabetic
    /** Checks whether the input is alphabetic only
     * param name: input string to be checked
     * returns true if string has alphabets else returns false
     */
    func isAlphabetic(name: String) -> Bool {
        return name.rangeOfString("^[a-zA-Z]+$", options: .RegularExpressionSearch) != nil
    }
    
    //MARK:ShowAlertView
    /** Shows alertview
     * param alertTitle: title on alert
     * param alertMessage: message on alertview
     */
    func showAlertView(alertTitle: String,alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
        
        let dismissAction = UIAlertAction(title: Constants.AlertViewMessages.alertButtonOk, style: .Default) { (action) -> Void in
        }
        alertController.addAction(dismissAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK:PushViewController
    /** Navigates to next screen
     */
    func pushViewController(){
        let weatherDetailsViewController: WeatherDetailsViewController = (self.storyboard?.instantiateViewControllerWithIdentifier(Constants.StoryBoardID.weatherDetailsViewController)
            as? WeatherDetailsViewController)!
        weatherDetailsViewController.cityName = cityName
        self.navigationController?.pushViewController(weatherDetailsViewController, animated: true)
    }
    
}