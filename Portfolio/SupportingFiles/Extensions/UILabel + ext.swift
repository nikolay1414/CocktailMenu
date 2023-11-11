//
//  UILabel + ext.swift
//  Portfolio
//
//  Created by Николай on 16.10.2023.
//

import Foundation
import UIKit

extension UILabel {
    
    static var signTopLabel: UILabel {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static var signBigLabel: UILabel {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    static var hintLabel: UILabel {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.alpha = 0.9
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    static var signLowLabel: UILabel {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func addTapActionToLabel(selector: Selector) {
        let loginTapGesture = UITapGestureRecognizer(target: self, action: selector)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(loginTapGesture)
    }
}
