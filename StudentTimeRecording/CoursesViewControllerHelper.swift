//
//  CoursesViewControllerHelper.swift
//  StudentTimeRecording
//
//  Created by HP on 14.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import CoreData

extension CoursesViewController {
    
    func createCourse(courseName: String, semester: Semester) {
        let course = NSEntityDescription.insertNewObject(forEntityName: "Course", into: managedContext!) as! Course
        course.courseName = courseName
        course.semester = semester
        course.date = NSDate()
    }
    
}
