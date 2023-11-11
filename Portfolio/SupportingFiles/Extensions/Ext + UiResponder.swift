//
//  Ext + UiResponder.swift
//  Portfolio
//
//  Created by Николай on 29.10.2023.
//

import Foundation
import UIKit

extension UIResponder {
    func findViewController() -> UIViewController? {
        if let viewController = self as? UIViewController {
            return viewController
        }
        if let next = self.next {
            return next.findViewController()
        }
        return nil
    }
}






