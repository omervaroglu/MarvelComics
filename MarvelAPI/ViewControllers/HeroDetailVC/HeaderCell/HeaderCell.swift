//
//  HeaderCell.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 1.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import UIKit
import CoreData

protocol setFavDelegate: class {
    func setFav(isFaved: Bool)
}

class HeaderCell: UITableViewCell {

    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    @IBOutlet weak var favImageView: UIImageView!
    
    weak var delegate: setFavDelegate?
    
    var isFaved: Bool = false{
        didSet{
            if isFaved == false {
                favImageView.image = UIImage(named: "emptyStar")
            } else {
                favImageView.image = UIImage(named: "yellowStar")
            }
        }
    }
    var hero: Hero?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(hero : Hero) {
        self.hero = hero
        heroImageView.dropShadowView()
        let imagePath: String = (hero.thumbnail?.path ?? "") + "." + (hero.thumbnail?.thumbnailExtension ?? "")
        setImg(image: heroImageView, imgLink: imagePath)
        heroNameLabel.text = hero.name ?? ""
        heroDescriptionLabel.text = hero.resultDescription ?? ""
    }

    @IBAction func favButtonAction(_ sender: Any) {
        !isFaved ? (isFaved = true) : (isFaved = false)
        self.delegate?.setFav(isFaved: isFaved)
    }
}

