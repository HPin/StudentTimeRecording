//
//  AddCourseViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 10.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class AddCourseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, NewSemesterSubviewControllerDelegate {
   
    let realmController = RealmController()
    var semesters: Results<Semester>!
    var selectedSemester: Semester?
    
    //let blackView = UIView()
    
    // pass reference to self into overlay, otherwise we encounter a nil object there
    lazy var addOverlay: NewSemesterSubViewController = {
        let overlay = NewSemesterSubViewController()
        overlay.addCourseViewController = self
        return overlay
    }()
    
    func refreshPicker() {
        semesterPicker.reloadAllComponents()
        
        if semesters.count >= 1 {
            selectedSemester = semesters[0]
        }
    }
    
    func dismissTheOverlay() {
        addOverlay.dismissOverlay()
    }
    
    @IBAction func newSemesterButton(_ sender: UIButton) {
        addOverlay.createOverlay()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newSemesterOverlaySegue" {
            if let sender = segue.destination as? NewSemesterSubViewController {
                sender.delegate = self
            }
        }
    }
    
    @IBOutlet weak var overlaySubview: UIView!
    
    @IBOutlet weak var semesterTextField: UITextField!
    
    @IBOutlet weak var semesterPicker: UIPickerView!
    
    @IBOutlet weak var abbreveationTextField: UITextField!
    
    @IBOutlet weak var addCourseTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)   // return from present modally
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        if (addCourseTextField.text != "") {
            
            let courseName = addCourseTextField.text!
            let courseNameShort = abbreveationTextField.text!
            
            realmController.addCourse(name: courseName, nameShort: courseNameShort, semester: selectedSemester!)
            
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return semesters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row < semesters.count {
            return semesters[row].name
        } else {
            return "no data available"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedSemester = semesters[row]
    }
    
    
    
    
        /*
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blackViewDisappear)))
        blackView.frame = view.frame
        blackView.alpha = 0
        
        view.addSubview(blackView)
        view.addSubview(overlaySubview) // add overlay after(!) black view
        
        let overlayHeight: CGFloat = 300
        //overlaySubview.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            
            let overlayYLocation = self.view.frame.height - overlayHeight
            self.overlaySubview.frame = CGRect(x: 0, y: overlayYLocation, width: self.view.frame.width, height: overlayHeight)
            
        }, completion: nil)
    }
    
    @objc func blackViewDisappear() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            self.overlaySubview.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
            
        }) { (completed: Bool) in
            self.blackView.removeFromSuperview()
            
            //self.coursesTableViewController?.showSettingsOverlay(setting: setting)
        }
    }
    */
    
//    lazy var managedContext: NSManagedObjectContext? = {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return nil
//        }
//        return appDelegate.persistentContainer.viewContext
//    }()
//    
//    
//    func save() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        appDelegate.saveContext()
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        semesters = realmController.getAllSemesters()
        
        if semesters.count >= 1 {
            selectedSemester = semesters[0]
        }
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlaySubview.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
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
