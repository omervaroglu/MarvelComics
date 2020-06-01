//
//  Date.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 1.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation

extension Date {
    func getDateString() -> String {
        let components = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second, .nanosecond], from: self)
        let day = components.day!
        let month = components.month!
        let year = components.year!
        if month < 10 {
            return "\(year)-0\(month)-\(day)"
        }else {
            return "\(year)-\(month)-\(day)"
        }
    }
}
