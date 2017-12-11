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
    
    let semesters:[[String]]
    
    let ws2017:[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemSize = UIScreen.main.bounds.width / 2 - 20   // - 3 because we use 3 pts spacing
        
        let customLayout = UICollectionViewFlowLayout()
        customLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)  // not really necessary
        customLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        customLayout.minimumInteritemSpacing = 20
        customLayout.minimumLineSpacing = 20
        
        CoursesCollectionView.collectionViewLayout = customLayout
    }
    
    override func viewDidLayoutSubviews() {
        //CoursesImageView.layer.cornerRadius = CoursesImageView.frame.size.height / 2
    }
    
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return semesters.count
    }
    
    // number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    // populate views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CoursesCollectionViewCell
        cell.abbreveationLabel.text = array[indexPath.row]
        return cell
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
