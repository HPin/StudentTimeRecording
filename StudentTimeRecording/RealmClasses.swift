//
//  RealmClasses.swift
//  StudentTimeRecording
//
//  Created by Jakob on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import Foundation
import RealmSwift

class Semester: Object{
    
    @objc dynamic var name = ""
    let courses = List<Course>()
    
}

class Course: Object{
    
    @objc dynamic var name = ""
    @objc dynamic var nameShort = ""
    
    let timeAtUniversity = List<myTime>()
    let timeAtHome = List<myTime>()
    let timeStudying = List<myTime>()
}

class myTime: Object{
    
    @objc dynamic var name = ""
    @objc dynamic var hours = 0
    @objc dynamic var minutes = 0
    @objc dynamic var date = Date()
    
}
