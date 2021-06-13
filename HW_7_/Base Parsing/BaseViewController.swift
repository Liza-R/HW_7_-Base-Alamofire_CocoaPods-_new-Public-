import UIKit

var cityNameBase: String = "" // needed for search city
    
class BaseViewController: UIViewController{
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feels_likeLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var today_weatherImage: UIImageView!
    @IBOutlet weak var weatherTable: UITableView!
    @IBOutlet weak var today_Label: UILabel!
     
    var massForTable: [forBaseTable] = [],
        dayForTable: [String] = [],
        alweatherInfo: [[forBaseTable]] = [[]],
        tableRowData: String = "",
        allData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameBase = searchTF.text!
        let viewModel = BaseViewModel()
        viewModel.weatherDelegate = self
        self.weatherTable.reloadData()
        self.weatherTable.dataSource = self
    }
    @IBAction func searchCityButton(_ sender: Any) {
        let alert = Alerts()
        if searchTF.text?.isEmpty == true{
            alert.alertNilTF(vc: self)
        }
        else{
            cityNameBase = searchTF.text!
            let changeURL = changeURL()
            changeURL.changeTodayURLBase(cityName: cityNameBase)
            changeURL.changeFiveDaysURLBase(cityName: cityNameBase)
            let viewModel = BaseViewModel()
            viewModel.weatherDelegate = self //без этого инфо не изменяется в UI

            if errorBase == true{
                alert.alertCityNotFound(vc: self, cityName: cityNameBase)
            }
        }
    }   
}

extension BaseViewController: uploadWeather{
    func uploadFiveDays(dayForTable_: [String], allData_: [String], massForTable_: [forBaseTable], cod: String, allWeatherInfo_ : [[forBaseTable]] = [[]]) {
        dayForTable = dayForTable_
        alweatherInfo = allWeatherInfo_
        allData = allData_
        massForTable = massForTable_
        weatherTable.reloadData()
    }
    
    func uploadToday(today: DaysInfo.All_Day_Info, description: String, image: UIImage, cod: Int) {
        let date = NSDate(timeIntervalSince1970: TimeInterval(today.dt)),
            dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "YYYY-MM-dd"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
     
        self.today_Label.text = "TODAY: \(dateString)"
        self.temperatureLabel.text = "\(String(describing: Int(today.main!.temp - 273.15)))°C \(cityNameBase)"
        self.maxLabel.text = "Max: \(String(describing: Int(today.main!.temp_max - 273.15)))°C "
        self.minLabel.text = "Min: \(String(describing: Int(today.main!.temp_min - 273.15)))°C "
        self.feels_likeLabel.text = "Feels like: \(String(describing: Int(today.main!.feels_like - 273.15)))°C"
        self.discriptionLabel.text = description
        self.today_weatherImage.image = image
    }
}

extension BaseViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayForTable.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weather_16", for: indexPath) as! WeatherTableViewCell
        
        tableRowData = dayForTable[indexPath.row]
        cell.dataForCollectionBase = alweatherInfo[indexPath.row]
        cell.collectionTable.reloadData()
        
        //day cell
        cell.day_Label.text = "\(tableRowData) \(cityNameBase)"
        return cell
    }
}

extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}

extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
