 //
//  CoursesViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 11.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

 class CoursesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var CoursesCollectionView: UICollectionView!
    
    let realmController = RealmController()
    var semesters : Results<Semester>!
    
    var selectedCourse: Course?
    
    let headerTitles:[String] = ["WS 2017/18", "SS 2017/18"]
    //let semesters:[[String]] = [["SEI", "FPS3", "MDT", "EMK", "PRO"], ["FPS2", "MDT", "PRO", "ABC"]]
    let images:[String] = ["bg1", "bg2", "bg3", "bg4", "bg5", "bg6", "bg7", "bg8", "bg9", "bg10", "bg11", "bg12", "bg13", "bg14", "bg15", "bg16", "bg17", "bg18", "bg19", "bg20", "bg21", "bg22", "bg23"]
    
    var blockOperations = [BlockOperation]()
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemSize = UIScreen.main.bounds.width / 2 - 20   // - 3 because we use 3 pts spacing
        
        let customLayout = UICollectionViewFlowLayout()
        customLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)  // not really necessary
        customLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        customLayout.headerReferenceSize = CGSize(width: 0, height: 50)
        
        customLayout.minimumInteritemSpacing = 20
        customLayout.minimumLineSpacing = 20
        
        CoursesCollectionView.collectionViewLayout = customLayout
        
        reloadCollectionView()
    }
    
    func reloadCollectionView() {
        
        semesters = realmController.getAllSemesters()
        CoursesCollectionView?.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        //CoursesCollectionView.layer.cornerRadius = CoursesCollectionView.frame.size.height / 2
    }
    
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return semesters.count
        
//        if let sections = fetchedResultsController.sections {
//            return sections.count
//        }
//        return 0
    }
    
    // number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return semesters[section].courses.count
        
//        if let sections = fetchedResultsController.sections {
//            let currentSection = sections[section]
//            return currentSection.numberOfObjects
//        }
//        return 0
    }
    
    // populate views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let coursesListEntry = self.fetchedResultsController.object(at: indexPath) as! Course
//        let labelText = coursesListEntry.courseName
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CoursesCollectionViewCell
        
        //cell.layer.cornerRadius = cell.frame.size.height / 2
        cell.layer.cornerRadius = 20
        
        cell.coursesCVCellImageView.image = UIImage(named: "\(images[semesters[indexPath.section].courses[indexPath.row].picId]).jpg")
        
        let labelText: String
        if indexPath.section < semesters.count {
            if indexPath.row < semesters[indexPath.section].courses.count {
                
                labelText = semesters[indexPath.section].courses[indexPath.row].nameShort
                
            } else {
                
                labelText = "no data available"
            }
        } else {
            
            labelText =  "no data available"
        }
        
        
        let strokeTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : 0.0,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 40)
            ] as [NSAttributedStringKey : Any]
        
        cell.abbreveationLabel.attributedText = NSAttributedString(string: labelText, attributes: strokeTextAttributes)
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "coursesSectionHeader", for: indexPath) as! CoursesSectionHeader
            
//            header.categoryTitleLabel.text = headerTitles[indexPath.section]
            header.categoryTitleLabel.text = semesters[indexPath.section].name
            
            return header
        default:
            assert(false, "Error...unexpected element kind encountered")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // save selected course (pass it later to details view contr.)
        
        if indexPath.section < semesters.count {
            if indexPath.row < semesters[indexPath.section].courses.count {
                selectedCourse = semesters[indexPath.section].courses[indexPath.row]
            } else {
            }
        } else {
        }
        
        performSegue(withIdentifier: "courseDetailsSegue", sender: self)
                                      
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "courseDetailsSegue" {
            if let detailsVC = segue.destination as? CourseDetailsTableViewController {
                
                detailsVC.selectedCourse = self.selectedCourse
                
            }
        }
    }
    
    
    
    // #######core data stuff:#########
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
    */
    // -------------------- update view -------------------------------------------
    /*
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.CoursesCollectionView.reloadData()
        //self.tableView.beginUpdates()
    }
  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            blockOperations.append(BlockOperation(block: {
                self.CoursesCollectionView.insertItems(at: [newIndexPath!])
            }))
           // self.CoursesCollectionView.insertItems(at: [newIndexPath!])
            //self.tableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            self.CoursesCollectionView.deleteItems(at: [indexPath!])
            //self.tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            break
        case .move:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.CoursesCollectionView.endEditing(true)
        //self.tableView.endUpdates()
        
        for operation in self.blockOperations {
            operation.start()
        }
        
    }
  */
    /*
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CoursesSectionHeader", for: indexPath) as! CoursesSectionHeader
        
        let category = semesters[indexPath.section]
        CoursesSectionHeader.categoryTitle = category
        
        return sectionHeaderView
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
