//
//  CoursesTableViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 10.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import RealmSwift

class CoursesTableViewController: UITableViewController {
    //UITableViewDelegate, UITableViewDataSource maybe need to be included as well
    
    //var courseClickedAtIndexPath: String!
    
    let realmController = RealmController()
    var semesters: Results<Semester>!
    
    @IBOutlet weak var coursesTableView: UITableView!
    
    // pass reference to self into AddOverlay, otherwise we encounter a nil object there
    lazy var addOverlay: AddOverlay = {
        let overlay = AddOverlay()
        overlay.coursesTableViewController = self
        return overlay
    }()
    @IBAction func overlayButton(_ sender: UIBarButtonItem) {
        addOverlay.showOverlay()
    }
    
    func showSettingsOverlay(setting: Setting) {
        
        
        
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name
        navigationController?.navigationBar.tintColor = UIColor.black
        //navigationController?.navigationBar.titleTextAttributes = [kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadTableView()
    }
    
    func reloadTableView() {
        
        semesters = realmController.getAllSemesters()
        tableView?.reloadData()
        
    }
    
    // -------------------- update view -------------------------------------------
    /*
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject:
        Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            break
        case .move:
            break
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    */
    
    // -------------------- create table view entries -------------------------------------------
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return semesters.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section < semesters.count {
            return semesters[section].courses.count
        } else {
            return 0
        }
        
        //return dataSource[section].courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(CoursesCustomCell.self, forCellReuseIdentifier: "coursesCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "coursesCell", for: indexPath)
        
        if indexPath.section < semesters.count {
            if indexPath.row < semesters[indexPath.section].courses.count {
                let currentCourse = semesters[indexPath.section].courses[indexPath.row]
                cell.textLabel?.text = currentCourse.nameShort
            } else {
                cell.textLabel?.text = "no data available"
            }
        } else {
            cell.textLabel?.text =  "no data available"
        }
        
//        let currentCourse = dataSource[indexPath.section].courses[indexPath.row]
//        cell.textLabel?.text = currentCourse.nameShort
        
        cell.textLabel?.numberOfLines = 0               // make new lines when out of bounds
        cell.backgroundColor = UIColor(red: 146/255, green: 144/255, blue: 0/255, alpha: 1)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = coursesTableView.cellForRow(at: indexPath) as! CoursesCustomCell
        
        //courseClickedAtIndexPath = currentCell.textLabel?.text
        
        performSegue(withIdentifier: "courseDetailsSegue", sender: self)
    }
    
    
    /*
    // -------------------- adds swipe to delete functionality ---------------
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "delete") { (action, indexPath) in
            // call closure function
            self.deleteElement(path: indexPath)
        }
        return [delete]
    }
    */
    func deleteElement(path: IndexPath) -> Void {
        
        /*
        let deleteThisElem = fetchedResultsController.object(at: path)
        self.managedContext?.delete(deleteThisElem)                 // delete from storage
        do {
            try self.managedContext?.save()                         // store changes
        } catch {
            print("Could not delete entry from list.")
        }
        */
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
