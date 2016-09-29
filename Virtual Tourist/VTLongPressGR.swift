//
//  VTLongPressGR.swift
//  Virtual Tourist
//
//  Created by Jacob Foster Davis on 9/29/16.
//  Copyright © 2016 Zero Mu, LLC. All rights reserved.
//

import Foundation
import UIKit

class VTLongPressGR: UILongPressGestureRecognizer {
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        
        self.minimumPressDuration = 1.0
        self.allowableMovement = 0.5
        
    }
    
}
