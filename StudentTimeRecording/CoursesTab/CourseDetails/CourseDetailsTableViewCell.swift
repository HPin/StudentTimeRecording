//
//  CourseDetailsTableViewCell.swift
//  StudentTimeRecording
//
//  Created by HP on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit

class CourseDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var coursesCellTextLabel: UILabel!
    
    @IBOutlet weak var timeTextLabel: UILabel!
    
    @IBOutlet weak var dateTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
