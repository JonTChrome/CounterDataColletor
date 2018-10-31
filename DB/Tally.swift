//
//  Tally.swift
//  Counter
//
//  Created by JTRACY9 on 10/22/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit
import RealmSwift

class Tally: Object {
    
    @objc dynamic var date: Date! = nil

    
    convenience init(date: Date) {
        self.init()
        self.date = date
    }
    
    static func getTodaysTallies() -> [Tally] {
        let realm = try! Realm()
        let calendar = Calendar.current
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        let predicate = NSPredicate(format: "date >= %@ AND date =< %@",argumentArray: [dateFrom, dateTo])
        let results = realm.objects(Tally.self).filter(predicate)
        return [Tally](results)
    }
}
