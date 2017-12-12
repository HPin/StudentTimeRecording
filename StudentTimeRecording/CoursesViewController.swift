 //
//  CoursesViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 11.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit

 class CoursesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var CoursesCollectionView: UICollectionView!
    
    let headerTitles:[String] = ["WS 2017/18", "SS 2017/18"]
    let semesters:[[String]] = [["SEI", "FPS3", "MDT", "EMK", "PRO"], ["FPS2", "MDT", "PRO", "ABC"]]
    let images:[String] = ["bg1", "bg2", "bg3", "bg4", "bg5", "bg6", "bg7", "bg8", "bg9", "bg10", "bg11", "bg12", "bg13", "bg14", "bg15", "bg16", "bg17", "bg18", "bg19", "bg20", "bg21", "bg22", "bg23"]
    
    
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
    }
    
    override func viewDidLayoutSubviews() {
        //CoursesCollectionView.layer.cornerRadius = CoursesCollectionView.frame.size.height / 2
    }
    
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return semesters.count
    }
    
    // number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return semesters[section].count
    }
    
    // populate views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CoursesCollectionViewCell
        
        cell.layer.cornerRadius = cell.frame.size.height / 2
        cell.coursesCVCellImageView.image = UIImage(named: "\(images[indexPath.row]).jpg")
        //cell.coursesCVCellImageView.image = UIImage(named: "bg14.jpg")
        let labelText = semesters[indexPath.section][indexPath.row]
        
        
        let strokeTextAttributes = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -5.0,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 40)
            ] as [NSAttributedStringKey : Any]
        
        cell.abbreveationLabel.attributedText = NSAttributedString(string: labelText, attributes: strokeTextAttributes)
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "coursesSectionHeader", for: indexPath) as! CoursesSectionHeader
            
            header.categoryTitleLabel.text = headerTitles[indexPath.section]
            
            return header
        default:
            assert(false, "Error...unexpected element kind encountered")
        }
        
    }
    
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
