//
//  AllLinks.swift
//  HW_7_
//
//  Created by Elizaveta Rogozhina on 13.05.2021.
//  Copyright © 2021 Lio Rin. All rights reserved.
//

import Foundation
 
var url_icon_upload = "http://openweathermap.org/img/wn/PICTURENAME@2x.png",
    
    url_today_uploadBase = "https://api.openweathermap.org/data/2.5/weather?q=\(cityNameBase)&appid=f786f3131537f8ee067b397b6f7753be",
    url_fiveDays_uploadBase = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityNameBase)&appid=f786f3131537f8ee067b397b6f7753be",
    url_today_uploadAlam = "https://api.openweathermap.org/data/2.5/weather?q=\(cityNameAlam)&appid=f786f3131537f8ee067b397b6f7753be",
    url_fiveDays_uploadAlam = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityNameAlam)&appid=f786f3131537f8ee067b397b6f7753be"
    

class changeURL{
    func changeTodayURLBase(cityName: String){
        url_today_uploadBase = "https://api.openweathermap.org/data/2.5/weather?q=\(cityNameBase)&appid=f786f3131537f8ee067b397b6f7753be"
    }
    func changeFiveDaysURLBase(cityName: String){
        url_fiveDays_uploadBase = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityNameBase)&appid=f786f3131537f8ee067b397b6f7753be"
    }
    
    func changeTodayURLAlam(cityName: String){
        url_today_uploadAlam = "https://api.openweathermap.org/data/2.5/weather?q=\(cityNameAlam)&appid=f786f3131537f8ee067b397b6f7753be"
    }
    func changeFiveDaysURLAlam(cityName: String){
        url_fiveDays_uploadAlam = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityNameAlam)&appid=f786f3131537f8ee067b397b6f7753be"
    }
}
