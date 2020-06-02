//
//  HeroDetailVC.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 1.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HeroDetailVC : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customNavBar: CustomNavBar!
    
    var characterID: Int = 0
    var hero : Hero?{
        didSet{
            self.characterID = hero?.id ?? 0
        }
    }
    var comics : [Comic] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    var savedHero : [Hero] = []
    var isFaved: Bool = false
    
    var headerCellNibName  = "HeaderCell"
    var ComicsCellNibName = "ComicsCell"
    
    override func viewDidLoad() {
        getData()
        fetchData()
        registerCell()
        setUI()
        getComics()
    }
    
    fileprivate func registerCell(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: headerCellNibName, bundle: nil), forCellReuseIdentifier: headerCellNibName)
        tableView.register(UINib(nibName: ComicsCellNibName, bundle: nil), forCellReuseIdentifier: ComicsCellNibName)
    }
    
    fileprivate func setUI(){
        self.overrideUserInterfaceStyle = .light
        
        tableView.contentInset = UIEdgeInsets(top: 60.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        customNavBar.backImageView.isHidden = false
        customNavBar.titleLabel.text = "CHARACTER"
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
    
    fileprivate func getComics() {
        Network.shared.getComics(viewController: self, parameters: nil, id: self.characterID) { (success, response) in
            if success {
                self.comics = response?.data?.results ?? []
            }else {
                //TODO: error message
            }
        }
    }
    
    fileprivate func fetchData(){
        for item in savedHero {
            if item.id == characterID {
                isFaved = true
                break
            }else {
                isFaved = false
            }
        }
    }
}
extension HeroDetailVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellNibName, for: indexPath) as! HeaderCell
            cell.delegate = self
            if let character = self.hero {
                cell.configure(hero: character)
            }
            cell.isFaved = self.isFaved
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ComicsCellNibName, for: indexPath) as! ComicsCell
            cell.comics = self.comics
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 420.0
        }
    }
}

extension HeroDetailVC : setFavDelegate {
    func setFav(isFaved: Bool) {
        if isFaved {
            saveData()
        } else {
            deleteDate()
        }
    }
}

extension HeroDetailVC {
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
    }

    fileprivate func saveData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let favItem = NSEntityDescription.insertNewObject(forEntityName: "FavItem", into: context)
        let imagePath: String = (hero?.thumbnail?.path ?? "") + "." + (hero?.thumbnail?.thumbnailExtension ?? "")
        
        favItem.setValue(hero?.name, forKey: "title")
        favItem.setValue(imagePath, forKey: "imagePath")
        favItem.setValue(hero?.id , forKey: "id")
        
        do {
            try context.save()
            print("Basarili")
        } catch {
            print(error)
        }
        
    }
    
    fileprivate func deleteDate() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavItem")
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let savedID = result.value(forKey: "id") as? Int, savedID == self.characterID {
                    context.delete(result)
                    do{
                        try context.save()
                    }catch {
                        
                    }
                    break
                }
            }
        } catch{
            
        }
    }

}
