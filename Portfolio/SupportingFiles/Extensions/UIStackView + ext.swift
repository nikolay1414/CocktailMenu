//
//  UIStackView + ext.swift
//  Portfolio
//
//  Created by Николай on 16.10.2023.
//

import Foundation
import UIKit

extension UIStackView {
    static var stackView: UIStackView {
        let sv = UIStackView()
        sv.axis = .vertical
//        sv.spacing = 10
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }
    
        func getArrangeViews(viewsToAdd: [UIView]) {
            for view in viewsToAdd {
                self.addArrangedSubview(view)
            }
        }
    
    

}
