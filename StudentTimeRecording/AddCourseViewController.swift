//
//  AddCourseViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 10.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import CoreData

class AddCourseViewController: UIViewController {

    
    @IBOutlet weak var semesterTextField: UITextField!
    
    @IBOutlet weak var abbreveationTextField: UITextField!
    
    @IBOutlet weak var addCourseTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)   // return from present modally
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        if (addCourseTextField.text != "") {
            
            let newCoursesListEntry = NSEntityDescription.insertNewObject(forEntityName: "Course", into: self.managedContext!) as! Course
            
            newCoursesListEntry.courseName = addCourseTextField.text!
            save()
            
            // return to course list
            //navigationController?.popViewController(animated: true) // show
            self.dismiss(animated: true, completion: nil)             // present modally
            
            addCourseTextField.text = "" // reset text field
        } else {
            let alert = UIAlertController(title: "ERROR", message: "You have to enter a course name first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    lazy var managedContext: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    
    func save() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.saveContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
