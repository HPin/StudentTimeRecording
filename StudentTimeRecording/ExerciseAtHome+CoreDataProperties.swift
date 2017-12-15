//
//  ExerciseAtHome+CoreDataProperties.swift
//  StudentTimeRecording
//
//  Created by Jakob on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseAtHome {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseAtHome> {
        return NSFetchRequest<ExerciseAtHome>(entityName: "ExerciseAtHome")
    }

    @NSManaged public var name: String?
    @NSManaged public var timeAmount: String?
    @NSManaged public var course: Course?

}
