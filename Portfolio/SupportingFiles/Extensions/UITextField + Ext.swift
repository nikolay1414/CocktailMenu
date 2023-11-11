//
//  UITextField + Ext.swift
//  Portfolio
//
//  Created by Николай on 16.10.2023.
//

import Foundation
import UIKit
extension UITextField {
    func setLeftPaddingView (padding: CGFloat) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 10))

        self.leftView = leftPaddingView
        self.leftViewMode = .always

    }
    
    func setRightPaddingView (button: UIButton) {
        self.rightView = button
        self.rightViewMode = .always
    }
}
