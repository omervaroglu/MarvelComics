//
//  CustomNavBar.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 1.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

class CustomNavBar : UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var rightItemImageView: UIImageView!
    
    var backButtonClicked: (() -> ())?
    var rightButtonClicked: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomNavBar", owner: self, options: nil)
        addSubview(navigationView)
        navigationView.frame = self.bounds
        navigationView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backImageView.isHidden = true
        self.rightItemImageView.isHidden = true
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.backButtonClicked?()
    }
    @IBAction func rightButtonAction(_ sender: Any) {
        self.rightButtonClicked?()
    }
}
