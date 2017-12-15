//
//  Course+CoreDataProperties.swift
//  StudentTimeRecording
//
//  Created by Jakob on 15.12.17.
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
    @NSManaged public var courseNameShort: String?
    @NSManaged public var semester: Semester?
    @NSManaged public var exerciseAtHome: NSSet?
    @NSManaged public var exerciseAtUni: NSSet?
    @NSManaged public var lectureAtHome: NSSet?
    @NSManaged public var lectureAtUni: NSSet?

}

// MARK: Generated accessors for exerciseAtHome
extension Course {

    @objc(addExerciseAtHomeObject:)
    @NSManaged public func addToExerciseAtHome(_ value: ExerciseAtHome)

    @objc(removeExerciseAtHomeObject:)
    @NSManaged public func removeFromExerciseAtHome(_ value: ExerciseAtHome)

    @objc(addExerciseAtHome:)
    @NSManaged public func addToExerciseAtHome(_ values: NSSet)

    @objc(removeExerciseAtHome:)
    @NSManaged public func removeFromExerciseAtHome(_ values: NSSet)

}

// MARK: Generated accessors for exerciseAtUni
extension Course {

    @objc(addExerciseAtUniObject:)
    @NSManaged public func addToExerciseAtUni(_ value: ExerciseAtUni)

    @objc(removeExerciseAtUniObject:)
    @NSManaged public func removeFromExerciseAtUni(_ value: ExerciseAtUni)

    @objc(addExerciseAtUni:)
    @NSManaged public func addToExerciseAtUni(_ values: NSSet)

    @objc(removeExerciseAtUni:)
    @NSManaged public func removeFromExerciseAtUni(_ values: NSSet)

}

// MARK: Generated accessors for lectureAtHome
extension Course {

    @objc(addLectureAtHomeObject:)
    @NSManaged public func addToLectureAtHome(_ value: LectureAtHome)

    @objc(removeLectureAtHomeObject:)
    @NSManaged public func removeFromLectureAtHome(_ value: LectureAtHome)

    @objc(addLectureAtHome:)
    @NSManaged public func addToLectureAtHome(_ values: NSSet)

    @objc(removeLectureAtHome:)
    @NSManaged public func removeFromLectureAtHome(_ values: NSSet)

}

// MARK: Generated accessors for lectureAtUni
extension Course {

    @objc(addLectureAtUniObject:)
    @NSManaged public func addToLectureAtUni(_ value: LectureAtUni)

    @objc(removeLectureAtUniObject:)
    @NSManaged public func removeFromLectureAtUni(_ value: LectureAtUni)

    @objc(addLectureAtUni:)
    @NSManaged public func addToLectureAtUni(_ values: NSSet)

    @objc(removeLectureAtUni:)
    @NSManaged public func removeFromLectureAtUni(_ values: NSSet)

}
