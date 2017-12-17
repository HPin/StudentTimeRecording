//
//  RealmController.swift
//  StudentTimeRecording
//
//  Created by Jakob on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import RealmSwift
import Foundation

class RealmController{
    
    
    func getAllSemesters() -> Results<Semester> {
        
        let realm = try! Realm()
        
        let allSemesters = realm.objects(Semester.self)
        return allSemesters
        
    }
    
    func addSemester(name: String){
        let realm = try! Realm()
        
        let semester = Semester()
        semester.name = name
        
        try! realm.write {
            realm.add(semester)
        }
    }
    
    
    func getSemester(nameSemester: String) -> Semester{
        let realm = try! Realm()
        let semester = realm.objects(Semester.self).filter("name == \(nameSemester)").first
        return semester!
    }
    
    func getCourse(nameSemester: String, nameCourse: String) -> Course?{
        
        let semester = getSemester(nameSemester: nameSemester)
        for course in semester.courses{
            
            if course.name == nameCourse{
                
                return course
            }
            
        }
        return nil
    }
    
    func addCourse(name: String, nameShort: String, semester: Semester){
        
        let realm = try! Realm()
        let course = Course()
        course.name = name
        course.nameShort = nameShort
        
        //var semester = getSemester(nameSemester: semesterName)
        try! realm.write {
            semester.courses.append(course)
            print("appending course: \(course.name)")
        }
    }
    
    
    func addTimeStudying(name: String, date: NSDate, amountTime: Int, courseName: String, semesterName: String){
        
        let realm = try! Realm()
        let time = myTime()
        time.amountTime = amountTime
        time.name = name
        time.date = date
        
        
        let semester = getSemester(nameSemester: semesterName)
        for course in semester.courses{
            
            if course.name == courseName{
                
                try! realm.write {
                    course.timeStudying.append(time)
                }
            }
            
        }
        
        
    }
    
    func addTimeAtHome(name: String, date: NSDate, amountTime: Int, courseName: String, semesterName: String){
        
        let realm = try! Realm()
        let time = myTime()
        time.amountTime = amountTime
        time.name = name
        time.date = date
        
        
        let semester = getSemester(nameSemester: semesterName)
        for course in semester.courses{
            
            if course.name == courseName{
                
                try! realm.write {
                    course.timeAtHome.append(time)
                }
            }
            
        }
        
        
    }
    
    func addTimeAtUniversity(name: String, date: NSDate, amountTime: Int, courseName: String, semesterName: String){
        
        let realm = try! Realm()
        let time = myTime()
        time.amountTime = amountTime
        time.name = name
        time.date = date
        
        
        let semester = getSemester(nameSemester: semesterName)
        for course in semester.courses{
            
            if course.name == courseName{
                
                try! realm.write {
                    course.timeAtUniversity.append(time)
                }
            }
            
        }
        
        
    }
    
}
