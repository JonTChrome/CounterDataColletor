//
//  ViewController.swift
//  Counter
//
//  Created by JTRACY9 on 10/22/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var unTally: UIButton!
    @IBOutlet weak var tally: UIButton!
    @IBOutlet weak var tickBox: UITextField!
    @IBOutlet weak var countLabel: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    let toDayView = "toDayView"
    
    var days: [Day]?
    let dateViewCell = "dateViewCell"
    var currentDay: Day?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(appBecameActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func appBecameActive() {
        loadDay()
        updateTally()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func untallyPressed(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            currentDay?.tallies.removeLast()
        }
        updateTally()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func loadDay() {
        let realm = try! Realm()
        days = [Day](realm.objects(Day.self))
        if let day = days?.last {
            let calendar = Calendar.current
            let dateFrom = calendar.startOfDay(for: day.date)
            let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
            if Date() > dateTo! {
                try! realm.write {
                    currentDay = Day()
                    realm.add(currentDay!)
                    days?.append(currentDay!)
                }
            } else {
                currentDay = day
            }
        } else {
            try! realm.write {
                currentDay = Day()
                realm.add(currentDay!)
                days?.append(currentDay!)
            }
        }
        days?.reverse()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (days == nil ? 0 : days!.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "DayView", bundle:nil).instantiateInitialViewController() as? DayViewController {
            vc.day = days?[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .none
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yep", style: .default, handler: { (action) in
                if let d = self.days?[indexPath.row] {
                    let realm = try! Realm()
                    try! realm.write {
                        self.days = nil
                        realm.delete(d)
                        self.loadDay()
                        self.tableView.reloadData()
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Nope", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dateViewCell, for: indexPath)
        if let c = cell as? DateViewCell {
            let index = indexPath.row
            if let day = days?[index] {
                c.populateDate(day)
            }
        }
        return cell
    }

    @IBAction func tallyPressed(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            currentDay?.tallies.append(Tally(date: Date()))
        }
        updateTally()
    }
    
    func updateTally() {
        let tallies = currentDay!.tallies.count
        tickBox.text = "\(tallies)"
        tableView.reloadData()
    }
    
}
