//
//  WeatherDetailsVIewController.swift
//  WeatherWebService
//
//  Created by komal lunkad on 29/09/16.
//  Copyright © 2016 komal lunkad. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet var labelLatitude: UILabel!
    @IBOutlet var labelLongitude: UILabel!
    @IBOutlet var labelMaxTemperature: UILabel!
    @IBOutlet var labelMinTemperature: UILabel!
    var weather:Weather? = Weather()
    var cityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        callWeatherApi(cityName!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:CallWeatherApi
    /** Calls Api and fetches data
    * param cityname: The input city whose data is to be fetched
    */
    func callWeatherApi(cityName:String) {
        let url = Constants.ApiDetails.url
        let appID = Constants.ApiDetails.appID
        let urlWithParameters = url + "?q=\(cityName)&appid=\(appID)"
        let fetchUrl : NSURL? = NSURL(string:urlWithParameters)
        let request = NSMutableURLRequest(URL: fetchUrl!)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error  in
            if error != nil
            {
                print("error=\(error)")
                return
            }
            do {
                guard let convertedJsonIntoDict = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    as? NSDictionary else{
                        return
                }
                self.parseWeather(convertedJsonIntoDict)
                self.showUI()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    //MARK:ParseWeather
    /** Parses ns dictionary and fetches the required data
     * param jsonDictionary: The dictionary to be parsed
     */
    func parseWeather(jsonDictionary:NSDictionary) {
        guard let latitude = jsonDictionary[Constants.ObjectNames.coord]?[Constants.AttributesNames.lat] as? Float else{
            return
        }
        guard let longitude = jsonDictionary[Constants.ObjectNames.coord]?[Constants.AttributesNames.lon] as? Float  else{
            return
        }
        guard let tempMax = jsonDictionary[Constants.ObjectNames.main]?[Constants.AttributesNames.tempMax] as? Float  else{
            return
        }
        guard let tempMin = jsonDictionary[Constants.ObjectNames.main]?[Constants.AttributesNames.tempMin] as? Float else{
            return
        }
        setWeatherValues(latitude, longitude: longitude, tempMax: convertFahrenheitToCelsius(tempMax), tempMin: convertFahrenheitToCelsius(tempMin))
    }
    
    //MARK:ConvertFahrenheitToCelsius
    /** Converts temperature from fahrenheit to celsius
     *param temperatureInFahrenheit: temperature value in Fahrenheit
     *returns temperature value in Celsius
     */
    func convertFahrenheitToCelsius(temperatureInFahrenheit:Float)->Float{
        return ((temperatureInFahrenheit-32)/1.8)
    }
    
    //MARK:SetWeatherValues
    /** Sets attributes of weather object
     * param latitude: latitude value
     * param longitude: longitude value
     * param tempMax: tempMax value
     * param tempMin: tempMin value
     */
    func setWeatherValues(latitude:Float,longitude:Float,tempMax:Float,tempMin:Float){
        self.weather!.latitude = latitude
        self.weather!.longitude = longitude
        self.weather!.tempMax = tempMax
        self.weather!.tempMin = tempMin
    }
    
    //MARK:ShowUI
    /** Sets label value
     */
    func showUI() {
        dispatch_async(dispatch_get_main_queue()) {
            self.labelLatitude.text = String("Latitude: \((self.weather?.latitude)!)")
            self.labelLongitude.text = String("Longitude: \((self.weather?.longitude)!)")
            self.labelMaxTemperature.text = String("MaxTemperature: \((self.weather!.tempMax)!)")
            self.labelMinTemperature.text = String("MinTemperature: \((self.weather!.tempMin)!)")
        }
    }
    
}
