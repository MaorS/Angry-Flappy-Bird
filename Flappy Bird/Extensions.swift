//
//  Extensions.swift
//  Flappy Bird
//
//  Created by Maor Shamsian on 23/04/2018.
//  Copyright © 2018 Maor Shamsian. All rights reserved.
//

import UIKit
import CoreGraphics
import SpriteKit

extension CGFloat{
    static func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    static func random(min  : CGFloat, max : CGFloat) -> CGFloat{
        return CGFloat.random() * (max - min) + min
    }
}

extension SKPhysicsContact {
    func isPhysicsContact(_ body1 : Physics, _ body2 : Physics) -> Bool{
        return self.bodyA.categoryBitMask == body1.value && bodyB.categoryBitMask == body2.value
    }
    
    func isBothPhysicsContact(_ body1 : Physics, body2 : Physics) -> Bool{
        return self.isPhysicsContact(body1 ,body2) || self.isPhysicsContact(body2 , body1)
    }
}

