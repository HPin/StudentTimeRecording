//
//  LectureAtUni+CoreDataProperties.swift
//  StudentTimeRecording
//
//  Created by Jakob on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//
//

import Foundation
import CoreData


extension LectureAtUni {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LectureAtUni> {
        return NSFetchRequest<LectureAtUni>(entityName: "LectureAtUni")
    }

    @NSManaged public var name: String?
    @NSManaged public var timeAmount: Int16
    @NSManaged public var course: Course?

}
