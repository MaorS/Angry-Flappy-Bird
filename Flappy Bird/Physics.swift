//
//  Physics.swift
//  Flappy Bird
//
//  Created by Maor Shamsian on 23/04/2018.
//  Copyright © 2018 Maor Shamsian. All rights reserved.
//
/// A mask that defines which categories this physics body belongs to.

import Foundation

struct Physics {
    static let bird : UInt32 = 0x1 << 1
    static let ground : UInt32 = 0x1 << 2
    static let wall : UInt32 = 0x1 << 3
    static let score : UInt32 = 0x1 << 4
}
