//
//  CoreDataMapViewController.swift
//  Virtual Tourist
//
//  Created by Jacob Foster Davis on 9/30/16.
//  Copyright © 2016 Zero Mu, LLC. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class CoreDataMapViewController: UIViewController, MKMapViewDelegate {
    
    /******************************************************/
    /******************* Properties **************/
    /******************************************************/
    //MARK: - Properties
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            // Whenever the frc changes, we execute the search and
            // reload the table
            fetchedResultsController?.delegate = self
            executeSearch()
            //TODO: Reload data
            //coreMapView.reloadData()
        }
    }
    
    var coreMapView: MKMapView!
    var stack: CoreDataStack!
    
    /******************************************************/
    /******************* Life Cycle **************/
    /******************************************************/
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the stack
        let delegate = UIApplication.shared.delegate as! AppDelegate
        stack = delegate.stack
        
    }
       
}

// MARK: - CoreDataMapViewController (Fetches)

extension CoreDataMapViewController {
    
    func executeSearch() {
        if let fc = fetchedResultsController {
            do {
                try fc.performFetch()
            } catch let e as NSError {
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController)")
            }
        }
    }
}

// MARK: - CoreDataMapViewController: NSFetchedResultsControllerDelegate

extension CoreDataMapViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if let thePin = anObject as? Pin {
        
            switch(type) {
            case .insert:
                //this will be done in the view controller so it can be selected
                //coreMapView.addAnnotation(thePin)
                
                print("case insert")
            case .delete:
                coreMapView.removeAnnotation(thePin)
            case .update:
                coreMapView.removeAnnotation(thePin)
                coreMapView.addAnnotation(thePin)
            case .move:
                coreMapView.removeAnnotation(thePin)
                coreMapView.addAnnotation(thePin)
            }
            
            //save
            stack.save()
        } else
        {
            fatalError("Couldn't get a pin from anObject in didChange")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //tableView.endUpdates()
    }
}
