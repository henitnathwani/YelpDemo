//
//  DefaultCell.swift
//  TestProject
//
//  Created by Henit Nathwani on 13/11/17.
//  Copyright © 2017 Henit Nathwani. All rights reserved.
//

import Foundation
import UIKit
import YelpAPI

class DefaultCell: BaseTableViewCell {
    @IBOutlet weak var labelTitle: LabelRegular!
    
    //MARK: LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelTitle.text = ""
    }
}
