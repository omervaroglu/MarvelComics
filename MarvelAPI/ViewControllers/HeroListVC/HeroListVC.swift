//
//  HeroListVC.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 31.05.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

class HeroListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var heroList: [Hero] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    var heroCellNibName  = "HeroTableViewCell"
    
    var limit = 0
    var offset = 0 {
        didSet{
            getCharacters()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getCharacters()
        setUI()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func setUI(){
        self.overrideUserInterfaceStyle = .light
        
        tableView.contentInset = UIEdgeInsets(top: 60.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        
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
    
    fileprivate func getCharacters(){
        Network.shared.getCharacters(viewController: self, parameters: nil, offset: offset) { (success, response) in
            if success {
                self.heroList.append(contentsOf: response?.data?.results ?? [])   
            }else {
                //TODO: error message
            }
        }
    }
}

extension HeroListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: heroCellNibName, for: indexPath) as! HeroTableViewCell
        cell.configure(hero: heroList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == heroList.count - 5) {
            self.offset = offset + 30
            
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = HeroDetailVC(nibName: "HeroDetailVC", bundle: nil)
        detailVC.hero = heroList[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
