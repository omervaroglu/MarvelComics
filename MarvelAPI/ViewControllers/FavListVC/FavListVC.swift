//
//  FavListVC.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 2.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavListVC : UIViewController {
    
    @IBOutlet weak var customNavBar: CustomNavBar!
    @IBOutlet weak var tableView: UITableView!
    
    var savedHero : [Hero] = []
    
    var heroCellNibName  = "HeroTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        getData()
        registerCell()
    }
    
    fileprivate func setUI(){
        self.overrideUserInterfaceStyle = .light
        
        tableView.contentInset = UIEdgeInsets(top: 60.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        customNavBar.backImageView.isHidden = false
        customNavBar.titleLabel.text = "FAVORITES"
        customNavBar.backButtonClicked = {
            self.navigationController?.popViewController(animated: true)
        }
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = Color.cream.value
            view.addSubview(statusbarView)
            
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = Color.cream.value
        }
    }
    
    fileprivate func registerCell(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: heroCellNibName, bundle: nil), forCellReuseIdentifier: heroCellNibName)
    }
    
}

extension FavListVC {
    fileprivate func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavItem")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    guard let title = result.value(forKey: "title") as? String else {
                        return
                    }
                    
                    guard let imagePath = result.value(forKey: "imagePath") as? String else {
                        return
                    }
                    
                    guard let id = result.value(forKey: "id") as? Int else {
                        return
                    }
                    let hero = Hero(id: id, name: title, resultDescription: nil, modified: nil, thumbnail: nil, resourceURI: nil, urls: nil, savedImagePath: imagePath)
                    self.savedHero.append(hero)
                }
            }
        } catch {
            
        }
        tableView.reloadData()
    }
}
extension FavListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedHero.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: heroCellNibName, for: indexPath) as! HeroTableViewCell
        cell.configureForFav(hero: savedHero[indexPath.row])
        return cell
    }
    
}
