//
//  Constants.swift
//  WeatherWebService
//
//  Created by komal lunkad on 30/09/16.
//  Copyright © 2016 komal lunkad. All rights reserved.
//

import Foundation
class Constants {
    struct StoryBoardID{
        static let weatherDetailsViewController = "WeatherDetailsViewController"
    }
    struct AlertViewMessages{
        static let alertViewTitle = "Alert"
        static let whiteSpaceMessage = "Textfield contains only Whitespaces"
        static let onlyAlphabetMessage = "City name should contain alphabets"
        static let alertButtonOk = "Ok"
    }
    struct ApiDetails {
        static let url = "http://api.openweathermap.org/data/2.5/weather"
        static let appID = "82d42d1bbaa0bbec840a96ca44a1660d"
    }
    struct ObjectNames {
        static let main = "main"
        static let coord = "coord"
    }
    struct AttributesNames {
        static let lat = "lat"
        static let lon = "lon"
        static let tempMin = "temp_min"
        static let tempMax = "temp_max"
    }
    struct RegularExpression {
        static let alphabeticRegularExpression = "^[a-zA-Z]+$"
    }
    struct LabelConstants {
        static let titleLatitude = "Latitude: "
        static let titleLongitude = "Longitude: "
        static let titleMaxTemp = "MaxTemperature: "
        static let titleMinTemp = "MinTemperature: "
        
    }
}