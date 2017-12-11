//
//  CoursesSectionHeader.swift
//  StudentTimeRecording
//
//  Created by HP on 11.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit

class CoursesSectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    var categoryTitle: String! {
        didSet {
            categoryTitleLabel.text = categoryTitle
        }
    }
    
}
