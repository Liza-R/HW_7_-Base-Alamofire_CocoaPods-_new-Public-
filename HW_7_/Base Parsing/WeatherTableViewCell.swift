import UIKit

class WeatherTableViewCell: UITableViewCell{
    
    @IBOutlet weak var day_Label: UILabel!
    @IBOutlet weak var collectionTable: UICollectionView!
    
    var dataForCollectionBase: [forBaseTable] = []
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionTable.delegate = self
        collectionTable.dataSource = self
        collectionTable.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataForCollectionBase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellWeather", for: indexPath) as! WeatherCollectionViewCell,
           options = dataForCollectionBase[indexPath.row]
        
        cell.tempLabelCell.text = "\(options.temper)"
        cell.iconImageCell.image = options.icon
        cell.descriptionLabelCell.text = "\(options.descript)"
        cell.timeLabelCell.text = options.time

        return cell
    }
}
extension WeatherTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{}
