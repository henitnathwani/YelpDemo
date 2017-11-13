//
//  Label.swift
//  TestProject
//
//  Created by Henit Nathwani on 13/11/17.
//  Copyright © 2017 Henit Nathwani. All rights reserved.
//

import Foundation
import UIKit

class Label: UILabel {
    
    
    //MARK: LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

class LabelRegular: Label {
    
    //MARK: LIFE CYCLE
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.font = UIFont.regularFontOfSize(size: self.font.pointSize)
    }
}


class LabelBold: Label {
    
    //MARK: LIFE CYCLE
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.font = UIFont.boldFontOfSize(size:self.font.pointSize)
    }
}
