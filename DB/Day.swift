//
//  Day.swift
//  Counter
//
//  Created by JTRACY9 on 10/22/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit
import RealmSwift

class Day: Object {
    
    @objc dynamic var date: Date = Date()
    let tallies = List<Tally>()

}
