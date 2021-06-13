import Foundation
import Alamofire

var errorBase = false

class TodayLoader{

    func loadTodayBase(completion: @escaping ([DaysInfo.All_Day_Info]) -> Void){
        
        URLSession.shared.dataTask(with: URL(string: url_today_uploadBase)!) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            do{
                errorBase = false
                 let today = try JSONDecoder().decode(DaysInfo.All_Day_Info.self, from: data)
                completion([today])
            }catch DecodingError.dataCorrupted(_) {
                errorBase = true
            } catch DecodingError.keyNotFound(_, _) {
                errorBase = true
            } catch DecodingError.valueNotFound(_, _) {
                errorBase = true
            } catch DecodingError.typeMismatch(_, _)  {
                errorBase = true
            }
            catch let error{
                errorBase = true
                print(error)
            }
        }.resume()
    }
    
    func loadTodayAlamofire(completion: @escaping ([DaysInfo.All_Day_Info]) -> Void){
        
        AF.request(URL(string: url_today_uploadAlam)!)
        .validate()
            .responseDecodable(of: DaysInfo.All_Day_Info.self) { (response) in
          guard let today = response.value else { return }
                completion([today])
                
        }
    }
}
