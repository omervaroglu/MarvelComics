//
//  setImage.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 1.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation
import Kingfisher

func setImg(image: UIImageView?, imgLink: String) -> (){
    let url = URL(string: imgLink)
    
    image!.kf.indicatorType = .activity
    image!.kf.setImage(
        with: url,
        placeholder: UIImage(named: "splash"),
        options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
    ])
}
func setImgWithCompletion(image: UIImageView?, imgLink: String, success: @escaping (_ isEmpty: Bool? )->()) -> (){
    //    let url = URL(string: imgLink)
    let url : String = imgLink
    let urlStr : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let convertedURL : URL = URL(string: urlStr)!
    print(convertedURL)
    
    image!.kf.indicatorType = .activity
    image!.kf.setImage(
        with: convertedURL,
        placeholder: nil,
        options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
    ])
}
