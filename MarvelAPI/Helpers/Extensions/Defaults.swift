//
//  Defaults.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 2.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    func set<T>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) where T : Decodable, T : Encodable {
        
    }

}
