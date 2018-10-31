//
//  DayViewCell.swift
//  Counter
//
//  Created by JTRACY9 on 10/23/18.
//  Copyright © 2018 JTRACY9. All rights reserved.
//

import UIKit

class DayViewCell: UITableViewCell {

    @IBOutlet weak var timestamp: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCell(_ tally: Tally) {
        timestamp.text = "\(tally.date!)"
    }

}
