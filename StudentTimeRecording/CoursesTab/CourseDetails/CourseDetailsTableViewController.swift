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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedCourse.timeStudying.count)
        print(selectedCourse.timeStudying[0].hours)
        print(selectedCourse.timeStudying[1].minutes)

        
        addTimeSubView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 400)
        
        reloadTableView()
    }
    
    // pass reference to self into overlay, otherwise we encounter a nil object there
    lazy var addTimeOverlay: AddTimeSubViewController = {
        let overlay = AddTimeSubViewController()
        overlay.courseDetailsTableViewController = self
        return overlay
    }()
    
    @IBAction func addNewTimeButton(_ sender: UIBarButtonItem) {
        addTimeOverlay.createOverlay()
    }
    
    func dismissTheOverlay() {
        addTimeOverlay.dismissOverlay()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newTimeOverlaySegue" {
            if let sender = segue.destination as? AddTimeSubViewController {
                sender.delegate = self
                sender.selectedCourse = self.selectedCourse
            }
        }
    }
    
    func reloadTableView() {
        semesters = realmController.getAllSemesters()
        courseDetailsTableView.reloadData()
    }
    
   
    
    // -------------------- create table view entries -------------------------------------------
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
        myHeader.backgroundColor = UIColor.lightGray
        
        let title = UILabel()
        let sectionTitles = ["Time at University", "Time at Home", "Time for Studying"]
        title.text = sectionTitles[section]
        title.frame = CGRect(x: 45, y: 10, width: view.frame.width - 45, height: 60)
        title.font = UIFont.systemFont(ofSize: 40)
        myHeader.addSubview(title)
        
        return myHeader
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if section == 0 {
            return selectedCourse.timeAtUniversity.count
        } else if section == 1 {
            return selectedCourse.timeAtHome.count
        } else if section == 2 {
            return selectedCourse.timeStudying.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //courseDetailsTableView.register(CourseDetailsTableViewCell.self, forCellReuseIdentifier: "courseDetailsCell")
        let cell = courseDetailsTableView.dequeueReusableCell(withIdentifier: "courseDetailsCell") as! CourseDetailsTableViewCell
        
        var currentTime = myTime()
        
        
        if indexPath.section == 0 {
            if indexPath.row < selectedCourse.timeAtUniversity.count {
                currentTime = selectedCourse.timeAtUniversity[indexPath.row]
                cell.coursesCellTextLabel.text = String(currentTime.hours)
            } else {
                cell.coursesCellTextLabel.text = "no data available"
            }
        } else if indexPath.section == 1 {
            if indexPath.row < selectedCourse.timeAtHome.count {
                currentTime = selectedCourse.timeAtHome[indexPath.row]
                cell.coursesCellTextLabel.text = String(currentTime.hours)
            } else {
                cell.coursesCellTextLabel.text = "no data available"
            }
        } else if indexPath.section == 2 {
            if indexPath.row < selectedCourse.timeStudying.count {
                currentTime = selectedCourse.timeStudying[indexPath.row]
                cell.coursesCellTextLabel.text = String(currentTime.hours)
            } else {
                cell.coursesCellTextLabel.text = "no data available"
            }
        } else {
            cell.coursesCellTextLabel.text = "no data available"
        }
        
        
        cell.coursesCellTextLabel.numberOfLines = 0
        cell.backgroundColor = UIColor(red: 146/255, green: 144/255, blue: 0/255, alpha: 1)
        
        return cell
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
