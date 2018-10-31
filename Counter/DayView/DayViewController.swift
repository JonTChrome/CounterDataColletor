//
//  DayViewController.swift
//  Counter
//
//  Created by JTRACY9 on 10/23/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit
import RealmSwift

class DayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateField: UITextField!
    let dayViewCell = "dayViewCell"
    
    var day: Day?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateField.text = dateFormatter.string(for: day?.date)
        navigationController?.navigationBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            try! realm.write {
                day?.tallies.remove(at: indexPath.row)
            }
        }
        tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (day == nil ? 0 : day!.tallies.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dayViewCell, for: indexPath)
        if let c = cell as? DayViewCell {
            let index = indexPath.row
            if let tally = day?.tallies[index] {
                c.populateCell(tally)
            }
        }
        return cell
    }
}
