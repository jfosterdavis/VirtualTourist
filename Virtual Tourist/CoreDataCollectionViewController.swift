//
//  CoreDataCollectionViewController.swift
//  Virtual Tourist
//
//  Created by Jacob Foster Davis on 10/8/16.
//  Copyright © 2016 Zero Mu, LLC. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataCollectionViewController: UIViewController, UICollectionViewDelegate {
    
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
    
    var collectionView: UICollectionView!
    var photosToDisplay = [FlickrPhoto]()
    
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

// MARK: - CoreDataCollectionViewController (Fetches)

extension CoreDataCollectionViewController {
    
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

// MARK: - CoreDataCollectionViewController: NSFetchedResultsControllerDelegate

extension CoreDataCollectionViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("About to reload collection view data")
        self.collectionView!.reloadData()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        //        let set = IndexSet(integer: sectionIndex)
        //
        //        switch (type) {
        //        case .insert:
        //            tableView.insertSections(set, with: .fade)
        //        case .delete:
        //            tableView.deleteSections(set, with: .fade)
        //        default:
        //            // irrelevant in our case
        //            break
        //        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if let theFlickrPhoto = anObject as? FlickrPhoto {
            
            switch(type) {
            case .insert:
                //this will be done in the view controller so it can be selected
                photosToDisplay.append(theFlickrPhoto)
                
                print("case insert")
            case .delete:
                //TODO: Delete from collection view
                photosToDisplay.removeObject(object: theFlickrPhoto)
                print("case delete")
            case .update:
                //TODO: replace a cell in the collection view
                print("case update")
            case .move:
                //TODO: move a cell... this may not be needed
                print("case move")
            }
            
            //save
            stack.save()
            
        } else
        {
            fatalError("Couldn't get a FlickrPhoto from anObject in didChange")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //tableView.endUpdates()
    }
}
