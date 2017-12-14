//
//  Course+CoreDataProperties.swift
//  StudentTimeRecording
//
//  Created by HP on 14.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var courseName: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var semester: Semester?

}
