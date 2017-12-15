//
//  CoursesTableViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 10.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import CoreData

class CoursesTableViewController: UITableViewController,  NSFetchedResultsControllerDelegate {
    //UITableViewDelegate, UITableViewDataSource maybe need to be included as well
    
    var courseClickedAtIndexPath: String!
    
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
    
    
    @IBOutlet weak var coursesTableView: UITableView!
    
   
    
    // -------------------- update view -------------------------------------------
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
    
    
    // -------------------- create table view entries -------------------------------------------
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(CoursesCustomCell.self, forCellReuseIdentifier: "coursesCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "coursesCell", for: indexPath)
        let controller = RealmController()
       
        cell.textLabel?.text = coursesListEntry.courseName
        cell.textLabel?.numberOfLines = 0               // make new lines when out of bounds
        cell.backgroundColor = UIColor(red: 146/255, green: 144/255, blue: 0/255, alpha: 1)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = coursesTableView.cellForRow(at: indexPath) as! CoursesCustomCell
        
        courseClickedAtIndexPath = currentCell.textLabel?.text
            
        print("-----------------------------")
        print(courseClickedAtIndexPath)
        
        performSegue(withIdentifier: "courseDetailsSegue", sender: self)
    }
    
    
    
    // -------------------- adds swipe to delete functionality ---------------
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
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
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
