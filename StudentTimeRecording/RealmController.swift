//
//  RealmController.swift
//  StudentTimeRecording
//
//  Created by Jakob on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import Foundation
import RealmSwift

class RealmController{
    
    
    func getAllSemester() -> Results<Semester>{
        
        let realm = try! Realm()
        
        let allSemester = realm.objects(Semester.self)
        
        return allSemester
        
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
    
    func addCourse(name: String, nameShort: String, semesterName: String){
        
        let realm = try! Realm()
        let course = Course()
        course.name = name
        course.nameShort = nameShort
        
        let semester = getSemester(nameSemester: semesterName)
        try! realm.write {
            semester.courses.append(course)
        }
       
    }
    
    func addExerciseUniTime(name: String, date: NSDate, amountTime: Int, courseName: String, semesterName: String){
        
        let realm = try! Realm()
        let time = myTime()
        time.amountTime = amountTime
        time.name = name
        time.date = date
        
        
        let semester = getSemester(nameSemester: semesterName)
        for course in semester.courses{
            
            if course.name == courseName{
                
                try! realm.write {
                    course.timeExerciseUni.append(time)
                }
            }
            
        }
        
        
    }
    
    func addExerciseHomeTime(name: String, date: NSDate, amountTime: Int, courseName: String, semesterName: String){
        
        let realm = try! Realm()
        let time = myTime()
        time.amountTime = amountTime
        time.name = name
        time.date = date
        
        
        let semester = getSemester(nameSemester: semesterName)
        for course in semester.courses{
            
            if course.name == courseName{
                
                try! realm.write {
                    course.timeExerciseHome.append(time)
                }
            }
            
        }
        
        
    }
    
    func addLectureUniTime(name: String, date: NSDate, amountTime: Int, courseName: String, semesterName: String){
        
        let realm = try! Realm()
        let time = myTime()
        time.amountTime = amountTime
        time.name = name
        time.date = date
        
        
        let semester = getSemester(nameSemester: semesterName)
        for course in semester.courses{
            
            if course.name == courseName{
                
                try! realm.write {
                    course.timeLectureUni.append(time)
                }
            }
            
        }
        
        
    }
    
    func addLectureHomeTime(name: String, date: NSDate, amountTime: Int, courseName: String, semesterName: String){
        
        let realm = try! Realm()
        let time = myTime()
        time.amountTime = amountTime
        time.name = name
        time.date = date
        
        
        let semester = getSemester(nameSemester: semesterName)
        for course in semester.courses{
            
            if course.name == courseName{
                
                try! realm.write {
                    course.timeLectureHome.append(time)
                }
            }
            
        }
        
        
    }
    
}
