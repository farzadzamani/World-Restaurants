//
//  SavedRestaurantDatasourceTableViewController.swift
//  World Restaurants
//
//  Created by Farzad on 2/13/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit
import CoreData
class SavedRestaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate{

    static var HideSection:[Int] = []
    var estimatedSectionHeaderHeight:CGFloat?
    lazy var fetchResultController: NSFetchedResultsController<SavedRestaurant> = {
        
        let fr = NSFetchRequest<SavedRestaurant>(entityName: "SavedRestaurant")
       let sortds = NSSortDescriptor(key: "countryGroup", ascending: true)
        fr.sortDescriptors = [sortds]
        
       //fr.predicate = NSPredicate(format: "countryGroup == %@", )
        let frc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: CoreDataStack.Shared.managedObjectContext, sectionNameKeyPath: "countryGroup", cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
        try fetchResultController.performFetch()
            
            let tableviewsize = tableView.frame.height - (self.tabBarController?.tabBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height
            let heightPerRow = Float(tableviewsize) / Float(CountryGroup.allGroup.count)
            estimatedSectionHeaderHeight = CGFloat(heightPerRow) / 1.25
            
        }catch {
                alert(view: self, title: "Error", message: "Program don't have access to Data Store")
            }
    
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchResultController.sections!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchResultController.sections![section].objects!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchResultController.sections?[section].name
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return estimatedSectionHeaderHeight!
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = tableView.dequeueReusableCell(withIdentifier: "ReusableHeaderViewCell") as! headerViewCell

        let sectionName = fetchResultController.sections?[section].name
        CountryGroup.allGroup.forEach({ (cg) in
            if cg.name == sectionName {
                headerView.restaurantGroupIcon.image =  cg.icon
            }
        })
        headerView.headerTitle.text = sectionName
        headerView.headerTitle.textColor = UIColor.black
        headerView.contentView.backgroundColor =  Theme.listItemBackground.color
        headerView.headerTitle.backgroundColor = Theme.listItemBackground.color
        
        ///Headerview Collapsed Button
        headerView.collepseButton.tag = section
        headerView.collepseButton.addTarget(self, action: #selector(collposedSection), for: .touchUpInside)
   
        return headerView

    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if SavedRestaurantTableViewController.HideSection.contains(indexPath.section) {
            return 0.0
        } else {
            return 40
        }
    }
    @objc func collposedSection(sender:UIButton){
        let section = sender.tag
           dump( SavedRestaurantTableViewController.HideSection)
        if SavedRestaurantTableViewController.HideSection.contains(section) {
            SavedRestaurantTableViewController.HideSection = SavedRestaurantTableViewController.HideSection.filter { $0 != section }
            dump( SavedRestaurantTableViewController.HideSection)
        } else {
            SavedRestaurantTableViewController.HideSection.append(section)
        }
        UIView.transition(with: tableView,
                          duration: 10,
                          options: .autoreverse,
                          animations: { self.tableView.reloadData() })
        

    
      
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseableSavedRestaurantCell", for: indexPath) as! SavedRestaurantViewCell
        //let obj = fetchResultController.fetchedObjects![indexPath.row] as SavedRestaurant
        let object = fetchResultController.sections?[indexPath.section].objects?[indexPath.row] as! SavedRestaurant
      
        cell.restaurantGroupName.text = object.name
        cell.contentView.backgroundColor = Theme.listItemBackground.color
        
        return cell
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSavedRestuarant = fetchResultController.sections?[indexPath.section].objects?[indexPath.row] as! SavedRestaurant
        self.performSegue(withIdentifier: "SavedRestaurantDetail", sender: selectedSavedRestuarant)
    }
    
}
    extension SavedRestaurantTableViewController {
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "SavedRestaurantDetail" {
                let vc:RestaurantDetailViewController = (segue.destination as? RestaurantDetailViewController)!
                guard let selectedSavedRestuarant = sender as? SavedRestaurant else {return}
          
                
                //vc.countryGroup = countryGroup
                vc.fetchedRestaurant = selectedSavedRestuarant
                vc.selectedRestaurantId = selectedSavedRestuarant.restaurantId
                vc.IsSavedRestaurant = true
                
            }
        }
    }

 


