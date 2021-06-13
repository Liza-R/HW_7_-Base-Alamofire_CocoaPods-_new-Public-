//
//  ViewModelBase.swift
//  HW_7_
//
//  Created by Elizaveta Rogozhina on 10.05.2021.
//  Copyright © 2021 Lio Rin. All rights reserved.
//

import Foundation
import UIKit

protocol uploadWeather{
    func uploadToday(today: DaysInfo.All_Day_Info, description: String, image: UIImage, cod: Int)
    func uploadFiveDays(dayForTable_: [String], allData_: [String], massForTable_: [forBaseTable], cod: String, allWeatherInfo_:  [[forBaseTable]])
}

class BaseViewModel{
    
    private var today: [DaysInfo.All_Day_Info] = [],
                five_days: [DaysInfo.All_Five_Days_Info] = [],
                dayForTable_F: [String] = [],
                allData_F: [String] = [],
                massForTable_F: [forBaseTable] = []
    
    var weatherDelegate: uploadWeather?

    let viewC = BaseViewController()
    
    init(){
        uploadToday()
        uploadDays()
    }
    
    func uploadToday(){
        TodayLoader().loadTodayBase { today in
            self.today = today
            DispatchQueue.main.async {
                for i in today{
                     var icon_today: String? = "",
                         image: UIImage? = nil,
                         descript: String = ""
                     
                     for j in i.weather{
                        icon_today = j?.icon
                        descript = j?.description ?? "Not Found"
                     }
                    
                    let url_icon = url_icon_upload.replacingOccurrences(of: "PICTURENAME", with: "\(icon_today!)")
                    
                     do {
                        let data = try Data(contentsOf: URL(string: url_icon)!, options: [])
                         image = UIImage(data: data)
                        self.weatherDelegate?.uploadToday(today: i, description: descript, image: image ?? .checkmark, cod: i.cod)
                     }
                     catch {
                         print(error.localizedDescription)
                     }
                }
            }
        }
    }
    
    func uploadDays(){
        
        var temp_: [String] = [],
            icon: [String] = [],
            icon_image: [UIImage] = [],
            descript: [String] = [],
            data: [String] = [],
            time: [String] = []
  
        let date = Date(),
        formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY-MM-dd"
        
        let result = formatter.string(from: date)

        TodayFiveDaysLoader().loadFiveDaysBase { five_days in
            self.five_days = five_days
            DispatchQueue.main.async {
                for i in five_days{
                    for (_, m) in i.list.enumerated(){
                        let denechek = m?.dt_txt.components(separatedBy: " ")
                        if denechek![0] != result{
                            temp_.append("\(String(describing: Int((m!.main!.temp) - 273.15)))°C")
                            data.append(denechek?[0] ?? "Not Found")
                            time.append(denechek?[1] ?? "Not Found")
                                for (_, w) in (m?.weather.enumerated())!{
                                    icon.append("\(w!.icon)")
                                    descript.append("\(w!.description)")
                                }
                            }
                        }
                    for (_, j) in icon.enumerated(){
                        let url_icon = url_icon_upload.replacingOccurrences(of: "PICTURENAME", with: "\(j)")
                        var image: UIImage? = nil
                            do{
                                let data = try Data(contentsOf: URL(string: url_icon)!, options: [])
                                image = UIImage(data: data)
                                icon_image.append(image!)
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                        }
                    for (i, j) in temp_.enumerated(){
                        let d: forBaseTable = forBaseTable(temper: j, icon: icon_image[i], descript: descript[i], data: data[i], time: time[i])
                        self.massForTable_F.append(d)
                    }

                    var set = Set<String>()
                    for i in self.massForTable_F{
                        self.allData_F.append(i.data)
                    }
                    self.dayForTable_F = self.allData_F.filter{ set.insert($0).inserted }
                    self.dayForTable_F = self.dayForTable_F.filter { $0 != "Not Found" }
                    self.dayForTable_F = self.dayForTable_F.filter { $0 != result }
                    
                    var allWeatherInfo_: [[forBaseTable]] = [[]]
                    
                    for _ in 0...self.dayForTable_F.count - 2{
                        allWeatherInfo_.append([])
                    }
                    
                    for (y, u) in self.dayForTable_F.enumerated(){
                        for (i, j) in self.allData_F.enumerated(){
                            if u == j{
                                allWeatherInfo_[y].append(self.massForTable_F[i])
                            }
                        }
                    }
                    self.weatherDelegate?.uploadFiveDays(dayForTable_: self.dayForTable_F, allData_: self.allData_F, massForTable_: self.massForTable_F, cod: i.cod, allWeatherInfo_: allWeatherInfo_)
                }
            }
        }
    }
}
