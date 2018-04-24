//
//  Physics.swift
//  Flappy Bird
//
//  Created by Maor Shamsian on 23/04/2018.
//  Copyright © 2018 Maor Shamsian. All rights reserved.
//
/// A mask that defines which categories this physics body belongs to.

import Foundation

enum Physics {
    case bird
    case ground
    case wall
    case score
    case none
    
    var value :  UInt32{
        switch self {
        case .bird:
            return 0x1 << 1
        case .ground:
            return 0x1 << 2
        case .wall:
            return 0x1 << 3
        case .score:
            return 0x1 << 4
        case .none :
            return 0xFFFFFFFF
        }
    }
}
