//
//  Extensions.swift
//  IOS_Collob
//
//  Created by webcodegenie on 20/06/24.
//

import Foundation
import UIKit
extension HomeViewController {
    func setGradientBackground(view: UIView) {
        let colorTop = UIColor(named: "TopColour")!.cgColor
        let colorBottom = UIColor(named: "BottomColour")!.cgColor
                    
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.3]
        gradientLayer.frame = view.bounds
                
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension UIView {
    func applyCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func makeCircle(){
        self.applyCornerRadius(radius: self.frame.width / 2)
    }
}

