//
//  BusinessDetailsViewController.swift
//  TestProject
//
//  Created by Henit Nathwani on 13/11/17.
//  Copyright © 2017 Henit Nathwani. All rights reserved.
//

import Foundation
import UIKit
import YelpAPI

class BusinessDetailsViewController: BaseViewController {

    //MARK: OUTLETS
    @IBOutlet weak var tableViewBusinessDetails: BusinessDetailsTableView!
    
    //MARK: VARIABLES
    var businessToDisplay : Business?
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        self.title = self.businessToDisplay?.businessName
        self.tableViewBusinessDetails.businessToDisplayDetails = self.businessToDisplay
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
