//
//  SplashVC.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 31.05.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

class SplashVC : UIViewController {
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        startHeroListVC()
    }
    
    func startHeroListVC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) { [weak self] in
            guard let strongSelf = self else { return }
            let startVC = HeroListVC(nibName: "HeroListVC", bundle: nil)
            let navVC = UINavigationController(rootViewController: startVC)
            strongSelf.window = UIWindow(frame: UIScreen.main.bounds)
            strongSelf.window?.rootViewController = navVC
            strongSelf.window?.makeKeyAndVisible()
        }
    }
}
