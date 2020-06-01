//
//  HeroDetailVC.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 1.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

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
    
    var headerCellNibName  = "HeaderCell"
    var ComicsCellNibName = "ComicsCell"
    
    override func viewDidLoad() {
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
    
    private func getComics() {
        Network.shared.getComics(viewController: self, parameters: nil, id: self.characterID) { (success, response) in
            if success {
                self.comics = response?.data?.results ?? []
            }else {
                //TODO: error message
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
            if let character = self.hero {
                cell.configure(hero: character)
            }
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
