//
//  GameModel.swift
//  Flappy Bird
//
//  Created by Maor Shamsian on 23/04/2018.
//  Copyright © 2018 Maor Shamsian. All rights reserved.
//

import UIKit
class GameModel{
    
    var gameStarted = false
    var score = 0
    var isDead = false
    
    func resetData(){
        self.gameStarted = false
        self.score = 0
        self.isDead = false
    }
    
}

