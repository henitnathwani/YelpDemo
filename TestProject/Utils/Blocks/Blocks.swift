//
//  Blocks.swift
//  TestProject
//
//  Created by Henit Nathwani on 13/11/17.
//  Copyright © 2017 Henit Nathwani. All rights reserved.
//

import Foundation
import YelpAPI

typealias SearchResultBlock = ([Business]) -> Void

typealias BusinessSelectionHandler = ((Business?) -> Void)?

typealias SaveBusinessLocallyBlock = (([Business]) -> Void)?
