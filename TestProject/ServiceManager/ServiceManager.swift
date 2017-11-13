//
//  AppDelegate.swift
//  TestProject
//
//  Created by Henit Nathwani on 13/11/17.
//  Copyright © 2017 Henit Nathwani. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import YelpAPI
import SVProgressHUD

class ServiceManager: NSObject {
	
    var yelpClient:YLPClient?
    let businessCategory = "restaurant"

    //MARK:- SHARED MANAGER
    static let shared : ServiceManager = {
        let instance = ServiceManager()
        
        if IS_INTERNET_AVAILABLE() {
            YLPClient.authorize(withAppId: YelpKeys.YelpAppId, secret: YelpKeys.YelpAppSecretKey, completionHandler: { (client, error) in
                print("Error : \(String(describing: error))")
                guard client != nil else {
                    return
                }
                instance.yelpClient = client!
            })
        }
        return instance
    }()
    
    override init() {
        super.init()
    }

    //MARK: GET SEARCH RESULTS
    func getSearchResult(fromCoordinate coordinate:YLPCoordinate, withSearchBlock search:@escaping SearchResultBlock) -> Void
    {

        if IS_INTERNET_AVAILABLE() {
            
            guard self.yelpClient != nil else {
                sleep(5)
                self.getSearchResult(fromCoordinate: coordinate, withSearchBlock: search)
                return
            }

            HUDUtils.showCustomLoader()

            self.yelpClient?.search(with: coordinate, term: self.businessCategory, limit: 10, offset: 1, sort: .bestMatched) { (result, error) in
                
                HUDUtils.hideCustomLoader()
                if error == nil
                {
                    //UPDATE LOCAL DATABASE AND GET ALL BUSINESSES
                    DatabaseManager.save(bussinesses: (result?.businesses)!, onCompletion: { (arrBusiness) in
                        search(arrBusiness)
                    })
                    
                }else {
                    AlertUtils.displayAlertWithMessage(message: (error?.localizedDescription)!)
                }
            }

        }else{
            // GET BUSINESSES FROM LOCAL DATABASE
            DatabaseManager.save(bussinesses: [], onCompletion: { (arrBusiness) in
                search(arrBusiness)
            })
        }
    }
}
