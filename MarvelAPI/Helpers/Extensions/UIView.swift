//
//  UIView.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 1.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadowView() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        self.layer.shadowRadius = 3
        self.layer.cornerRadius = 12
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
