//
//  Extensions.swift
//  Flappy Bird
//
//  Created by Maor Shamsian on 23/04/2018.
//  Copyright © 2018 Maor Shamsian. All rights reserved.
//

import UIKit
import CoreGraphics

extension CGFloat{
    static func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    static func random(min  : CGFloat, max : CGFloat) -> CGFloat{
        return CGFloat.random() * (max - min) + min
    }
}
