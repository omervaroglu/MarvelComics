//
//  ComicCollectionCell.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 1.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import UIKit

class ComicCollectionCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var comicsImageView: UIImageView!
    @IBOutlet weak var comicsNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(comic: Comic) {
        let imagePath: String = (comic.thumbnail?.path ?? "") + "." + (comic.thumbnail?.thumbnailExtension ?? "")
        setImg(image: comicsImageView, imgLink: imagePath)
        comicsNameLabel.text = comic.title ?? ""
    }

}
