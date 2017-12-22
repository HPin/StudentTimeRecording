//
//  DeadlinesTableViewCell.swift
//  StudentTimeRecording
//
//  Created by Jakob on 22.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit

class DeadlinesTableViewCell: UITableViewCell {

    @IBOutlet weak var deadlineCellName: UILabel!
    @IBOutlet weak var deadlineCellDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
