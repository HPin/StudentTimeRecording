//
//  LectureAtHome+CoreDataProperties.swift
//  StudentTimeRecording
//
//  Created by Jakob on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//
//

import Foundation
import CoreData


extension LectureAtHome {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LectureAtHome> {
        return NSFetchRequest<LectureAtHome>(entityName: "LectureAtHome")
    }

    @NSManaged public var name: String?
    @NSManaged public var timeAmount: Int16
    @NSManaged public var course: Course?

}
