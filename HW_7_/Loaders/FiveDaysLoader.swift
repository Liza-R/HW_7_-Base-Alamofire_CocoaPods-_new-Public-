import Foundation
import Alamofire
import SwiftSpinner

var errorCoding = false

class TodayFiveDaysLoader{
 
    func loadFiveDaysBase(completion: @escaping ([DaysInfo.All_Five_Days_Info]) -> Void){

        URLSession.shared.dataTask(with: URL(string: url_fiveDays_uploadBase)!) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            DispatchQueue.main.async {
                do{
                    SwiftSpinner.show("Загрузка погоды \(cityNameBase)")
                    let five_days = try JSONDecoder().decode(DaysInfo.All_Five_Days_Info.self, from: data)
                    completion([five_days])
                }
                catch let error{
                    print(error)
                }
                SwiftSpinner.hide()
            }
        }.resume()
    }
    
    func loadFiveDaysAlamofire(completion: @escaping ([DaysInfo.All_Five_Days_Info]) -> Void){
        AF.request(URL(string: url_fiveDays_uploadAlam)!)
        .validate()
            .responseDecodable(of: DaysInfo.All_Five_Days_Info.self) { (response) in
                    guard let five_days = response.value else { return }
                    completion([five_days])
        }
    }
}
