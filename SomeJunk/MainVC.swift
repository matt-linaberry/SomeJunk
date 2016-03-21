//
//  ViewController.swift
//  SomeJunk
//
//  Created by Matthew Linaberry on 3/21/16.
//  Copyright © 2016 MRS Electronic, Inc. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var fetchedResultsController: NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        //generateTestData()
        attemptFetch()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        if let item = fetchedResultsController.objectAtIndexPath(indexPath) as? Item {
            // TODO: Update Data
            cell.configureCell(item)
        }
    }
    
    func attemptFetch() {
        setFetchedResults()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let error = error as NSError
            print("\(error.debugDescription)")
        }
    }
    
    func setFetchedResults() {
        let section: String? = segment.selectedSegmentIndex == 1 ? "store.name" : nil
        let fetchRequest = NSFetchRequest(entityName: "Item")
        
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: section, cacheName: nil)
        
        controller.delegate = self
        fetchedResultsController = controller
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch(type) {
            // listen for the different types of updates here
        case .Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            }
            break
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break
        case .Update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! ItemCell
                // TODO: Update cell data
                configureCell(cell, indexPath: indexPath)
            }
            break
        case .Move:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                if let newIndexPath = newIndexPath {
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
                }
            }
            break
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func generateTestData() {
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
        
        item.title = "Cool Lego Set"
        item.price = 45.99
        item.details = "This is a super cool STAR WARS Lego set with a thousand pieces"
        let item2 = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
        
        item2.title = "He Man vs Skelator"
        item2.price = 99.99
        item2.details = "Skelator is the man with a plan... kinda."
        
        let item3 = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
        
        item3.title = "Audi R8"
        item3.price = 108000
        item3.details = "I will probably die in this car. But I will buy it anyway."
        
        ad.saveContext()
        
    }


}

