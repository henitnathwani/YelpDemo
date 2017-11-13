//
//  DatabaseManager.swift
//  TestProject
//
//  Created by Henit Nathwani on 13/11/17.
//  Copyright © 2017 Henit Nathwani. All rights reserved.
//

import Foundation
import YelpAPI
import CoreData
import SDWebImage


class DatabaseManager : NSObject {
    
    //MARK: SAVE BUSINESSES
    class func save(bussinesses arrayBusiness : [YLPBusiness], onCompletion completionHandler:SaveBusinessLocallyBlock) -> Void {
        
        
        for business in arrayBusiness {

            // CHECKING IF THE RECEIVED BUSINESS ALREADY EXISTS OR NOT
            var businessToAddOrUpdate : Business?
            let fetchRequest: NSFetchRequest<Business> = Business.fetchRequest()
            let predicateBusinessIdentifier = NSPredicate(format: "businessIdentifier == %@",business.identifier)
            fetchRequest.predicate = predicateBusinessIdentifier
            let arrBusiness = try! appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            
            // IF A BUSINESS EXISTS, THEN UPDATE THE DETAILS WITH LATEST ONES, ELSE INSERT NEW RECORD
            if arrBusiness.count > 0 {
                businessToAddOrUpdate = arrBusiness.first
            }else{
                businessToAddOrUpdate = NSEntityDescription.insertNewObject(forEntityName: "Business", into: appDelegate.persistentContainer.viewContext) as? Business
            }
            
            // SETTING UP THE BUSINESS DETAILS
            businessToAddOrUpdate?.businessName = business.name
            businessToAddOrUpdate?.businessIdentifier = business.identifier
            businessToAddOrUpdate?.businessAddress = business.location.address.joined(separator: ", ")
            businessToAddOrUpdate?.businessPhone = business.phone
            businessToAddOrUpdate?.businessURL = business.url.absoluteString
            businessToAddOrUpdate?.businessImageURL = business.imageURL?.absoluteString
            businessToAddOrUpdate?.businessRating = business.rating
            businessToAddOrUpdate?.businessReviewsCount = Int64(business.reviewCount)
            businessToAddOrUpdate?.latitude = (business.location.coordinate?.latitude)!
            businessToAddOrUpdate?.longitude = (business.location.coordinate?.longitude)!
            
            // SAVING BUSINESS CATEGORIES
            var arrCategories : [Category] = []
            for category in business.categories {
                
                let categoryToAdd = NSEntityDescription.insertNewObject(forEntityName: "Category", into: appDelegate.persistentContainer.viewContext) as? Category
                categoryToAdd?.catgoryName = category.name
                categoryToAdd?.categoryAlias = categoryToAdd?.categoryAlias
                arrCategories.append(categoryToAdd!)
            }

            businessToAddOrUpdate?.categories = NSSet(array: arrCategories)
            
        }
        appDelegate.saveContext()
        
        guard completionHandler != nil else {
            return
        }
        
        // RETURNING ALL BUSINESSES FROM LOCAL DATABASE
        let fetchRequest: NSFetchRequest<Business> = Business.fetchRequest()
        let arrBusinessToReturn = try! appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
        completionHandler!(arrBusinessToReturn)
    }

}


