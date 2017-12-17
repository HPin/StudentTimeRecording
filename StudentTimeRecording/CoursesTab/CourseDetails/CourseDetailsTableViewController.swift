//
//  CourseDetailsTableViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CourseDetailsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    var courseClickedAtIndexPath: String!
    
    let realmController = RealmController()
    var semesters: Results<Semester>!

    @IBOutlet weak var courseDetailsTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
        print("----------datasource count--------------")
        print(semesters.count)    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadTableView()
    }
    
    
    func reloadTableView() {
        semesters = realmController.getAllSemesters()
        courseDetailsTableView.reloadData()
    }
    
    /*
    // -------------------- create context -------------------------------------------
    lazy var managedContext: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    // -------------------- query -------------------------------------------
    lazy var fetchedResultsController: NSFetchedResultsController<NSManagedObject> = {
        let request = NSFetchRequest<NSManagedObject>(entityName: "Course")
        request.fetchBatchSize = 20
        request.fetchLimit = 100
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true) // sort by date
        request.sortDescriptors = [sortDescriptor]
        let frc = NSFetchedResultsController<NSManagedObject>(fetchRequest: request, managedObjectContext:
            self.managedContext!, sectionNameKeyPath: nil, cacheName: "Cache")
        frc.delegate = self
        // perform initial model fetch
        do {
            try frc.performFetch()
        } catch let e as NSError {
            print("Fetch error: \(e.localizedDescription)")
            abort();
        }
        return frc
    }()
    
    
    // -------------------- update view -------------------------------------------
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        courseDetailsTableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject:
        Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            courseDetailsTableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            courseDetailsTableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            break
        case .move:
            break
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        courseDetailsTableView.endUpdates()
    }
    */
    
    // -------------------- create table view entries -------------------------------------------
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return semesters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("----------datasource at section courses count--------------")
        print(semesters[section].courses.count)
        return semesters[section].courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //courseDetailsTableView.register(CourseDetailsTableViewCell.self, forCellReuseIdentifier: "courseDetailsCell")
        let cell = courseDetailsTableView.dequeueReusableCell(withIdentifier: "courseDetailsCell") as! CourseDetailsTableViewCell
        
        let currentCourse = semesters[indexPath.section].courses[indexPath.row]
        
        cell.textLabel?.text = currentCourse.nameShort
        cell.textLabel?.numberOfLines = 0               // make new lines when out of bounds
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
