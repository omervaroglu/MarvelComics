//
//  ComicsCell.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 1.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import UIKit

class ComicsCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var comics: [Comic] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var ComicCollectionCellNibName  = "ComicCollectionCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    fileprivate func registerCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ComicCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ComicCollectionCell")
    }
    
}
extension ComicsCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicCollectionCell", for: indexPath) as! ComicCollectionCell
        cell.configure(comic: comics[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0 , height: 300.0)
    }
}
