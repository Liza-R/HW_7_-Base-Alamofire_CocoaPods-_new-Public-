//
//  AllAlerts.swift
//  HW_7_
//
//  Created by Elizaveta Rogozhina on 14.05.2021.
//  Copyright © 2021 Lio Rin. All rights reserved.
//

import Foundation
import UIKit

class Alerts{
    func alertNilTF(vc: UIViewController){
 
        let alert = UIAlertController(title: "Enter city", message: "The search string must not be empty", preferredStyle: UIAlertController.Style.actionSheet),
        cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)

         alert.addAction(cancelAction)
         alert.pruneNegativeWidthConstraints()
         vc.present(alert, animated: true, completion: nil)
    }
    func alertCityNotFound(vc: UIViewController, cityName: String){
 
        let alert = UIAlertController(title: "City \(cityName) not found", message: "Enter another city", preferredStyle: UIAlertController.Style.actionSheet),
        cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)

         alert.addAction(cancelAction)
         alert.pruneNegativeWidthConstraints()
         vc.present(alert, animated: true, completion: nil)
    }
}
