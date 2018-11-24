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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
            let headerView = tableView.dequeueReusableCell(withIdentifier: "ReusableHeaderViewCell") as! headerViewCell
                
//                headerView.headerTitle.text = fetchResultController.sections?[section].name
//                headerView.headerTitle.textColor = UIColor.white
//                headerView.contentView.backgroundColor = CountryGroup.allGroup[section].color
//                headerView.headerTitle.backgroundColor = CountryGroup.allGroup[section].color

        headerView.headerTitle.text = fetchResultController.sections?[section].name
        headerView.headerTitle.textColor = CountryGroup.allGroup[section].color
        headerView.contentView.backgroundColor =  UIColor.white
        headerView.headerTitle.backgroundColor = UIColor.white
       
        return headerView
        
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseableSavedRestaurantCell", for: indexPath) as! SavedRestaurantViewCell
        let object = fetchResultController.sections?[indexPath.section].objects?[indexPath.row] as! SavedRestaurant
        
        cell.restaurantGroupName.text = object.name
        
        
        cell.textLabel?.textColor = CountryGroup.allGroup[indexPath.section].color
        cell.contentView.backgroundColor =  UIColor.white
        
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

 


