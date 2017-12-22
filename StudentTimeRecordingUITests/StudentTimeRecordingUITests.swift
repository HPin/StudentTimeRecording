//
//  StudentTimeRecordingUITests.swift
//  StudentTimeRecordingUITests
//
//  Created by HP on 08.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import XCTest

class StudentTimeRecordingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
                // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.buttons["Start now!"].tap()
        app.navigationBars["StudentTimeRecording.CoursesView"].buttons["Add"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["Create a new Semester"].tap()
        app.navigationBars["New Semester"].buttons["Save"].tap()
        
        let courseNameTextField = elementsQuery.textFields["Course Name"]
        courseNameTextField.tap()
        courseNameTextField.typeText("Hallo")
        
        let courseAbbreveationTextField = elementsQuery.textFields["Course Abbreveation"]
        courseAbbreveationTextField.tap()
        courseAbbreveationTextField.tap()
        courseAbbreveationTextField.typeText("Hallo")
        elementsQuery.navigationBars["New Course"].buttons["Save"].tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["HALLO"]/*[[".cells.staticTexts[\"HALLO\"]",".staticTexts[\"HALLO\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["StudentTimeRecording.CourseDetailsTableView"].buttons["Add"].tap()
        // it fails when i click on the textfield??
        
        
    }
    
}
