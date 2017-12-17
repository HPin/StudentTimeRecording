//
//  CourseDetailsTableViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import RealmSwift

class CourseDetailsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTimeSubViewControllerDelegate {
    
    
    let realmController = RealmController()
    var semesters: Results<Semester>!
    
    var selectedCourse: Course!

    @IBOutlet weak var courseDetailsTableView: UITableView!
    
    @IBOutlet weak var addTimeSubView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
        print("----------datasource count--------------")
        print(semesters.count)    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTimeSubView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
        
        reloadTableView()
    }
    
    // pass reference to self into overlay, otherwise we encounter a nil object there
    lazy var addOverlay: AddTimeSubViewController = {
        let overlay = AddTimeSubViewController()
        overlay.courseDetailsTableViewController = self
        return overlay
    }()
    
    @IBAction func addNewTimeButton(_ sender: UIBarButtonItem) {
        addOverlay.createOverlay()
    }
    
    func dismissTheOverlay() {
        addOverlay.dismissOverlay()
    }
    
    func reloadTableView() {
        semesters = realmController.getAllSemesters()
        courseDetailsTableView.reloadData()
    }
    
   
    
    // -------------------- create table view entries -------------------------------------------
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //courseDetailsTableView.register(CourseDetailsTableViewCell.self, forCellReuseIdentifier: "courseDetailsCell")
        let cell = courseDetailsTableView.dequeueReusableCell(withIdentifier: "courseDetailsCell") as! CourseDetailsTableViewCell
        
        let currentCourse = semesters[indexPath.section].courses[indexPath.row]
        
        
        cell.coursesCellTextLabel.text = currentCourse.nameShort
        cell.coursesCellTextLabel.numberOfLines = 0
        cell.backgroundColor = UIColor(red: 146/255, green: 144/255, blue: 0/255, alpha: 1)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! CourseDetailsTableViewCell
        
        //courseClickedAtIndexPath = currentCell.textLabel?.text
        
        performSegue(withIdentifier: "courseDetailsSegue", sender: self)
    }
    
    
    /*
    // -------------------- adds swipe to delete functionality ---------------
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "delete") { (action, indexPath) in
            // call closure function
            self.deleteElement(path: indexPath)
        }
        return [delete]
    }
    
    func deleteElement(path: IndexPath) -> Void {
        let deleteThisElem = fetchedResultsController.object(at: path)
        self.managedContext?.delete(deleteThisElem)                 // delete from storage
        do {
            try self.managedContext?.save()                         // store changes
        } catch {
            print("Could not delete entry from list.")
        }
    }
    */
    
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
