//
//  DateViewCell.swift
//  Counter
//
//  Created by JTRACY9 on 10/22/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit

class DateViewCell: UITableViewCell {

    @IBOutlet weak var tally: UITextField!
    @IBOutlet weak var date: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateDate(_ day: Day) {
        tally.text = "\(day.tallies.count)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        date.text = dateFormatter.string(for: day.date)
   }

}
