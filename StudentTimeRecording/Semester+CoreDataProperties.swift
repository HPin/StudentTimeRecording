//
//  Semester+CoreDataProperties.swift
//  StudentTimeRecording
//
//  Created by HP on 14.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//
//

import Foundation
import CoreData


extension Semester {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Semester> {
        return NSFetchRequest<Semester>(entityName: "Semester")
    }

    @NSManaged public var semesterName: String?
    @NSManaged public var courses: NSSet?

}

// MARK: Generated accessors for courses
extension Semester {

    @objc(addCoursesObject:)
    @NSManaged public func addToCourses(_ value: Course)

    @objc(removeCoursesObject:)
    @NSManaged public func removeFromCourses(_ value: Course)

    @objc(addCourses:)
    @NSManaged public func addToCourses(_ values: NSSet)

    @objc(removeCourses:)
    @NSManaged public func removeFromCourses(_ values: NSSet)

}
