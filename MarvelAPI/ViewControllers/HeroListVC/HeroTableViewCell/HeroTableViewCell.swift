//
//  HeroTableViewCell.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 31.05.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var imageBackgrounView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(hero : Hero){
        heroImageView.dropShadowView()
        let imagePath: String = (hero.thumbnail?.path ?? "") + "." + (hero.thumbnail?.thumbnailExtension ?? "")
        setImg(image: heroImageView, imgLink: imagePath)
        heroNameLabel.text = hero.name
    }
    
    public func configureForFav(hero: Hero) {
        heroImageView.dropShadowView()
        setImg(image: heroImageView, imgLink: hero.savedImagePath ?? "")
        heroNameLabel.text = hero.name
    }

}
