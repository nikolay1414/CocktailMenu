//
//  AlertPassword.swift
//  Portfolio
//
//  Created by Николай on 16.10.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
   func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Cancel", style: .cancel)
           alert.addAction(action)
           present(alert, animated: true)
       
    }
}

