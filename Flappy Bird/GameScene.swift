//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Maor Shamsian on 23/04/2018.
//  Copyright © 2018 Maor Shamsian. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var ground = SKSpriteNode()
    private var bird = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        // ground
        addGround()
        // bird
        addBird()
        
        createWalls()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    private func addGround(){
        ground = SKSpriteNode(imageNamed: "image_ground")
        ground.setScale(0.5)
        let groundX = self.frame.width / 2
        let groundY = ground.frame.height / 2
        ground.position = CGPoint(x: groundX, y: groundY)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        self.addChild(ground)
    }
    
    func addBird(){
        bird = SKSpriteNode(imageNamed: "image_bird")
        bird.size = CGSize(width: 60, height: 60)
        let birdX = self.frame.width / 2 - bird.frame.width
        let birdY = self.frame.height / 2
        bird.position = CGPoint(x: birdX, y: birdY)
        self.addChild(bird)
        
    }
    
    private func createWalls(){
        let walls = SKNode()
        let topWall = SKSpriteNode(imageNamed: "image_wall")
        let bottomWall = SKSpriteNode(imageNamed: "image_wall")
        
        topWall.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 350)
        
        bottomWall.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 - 350)
        
        topWall.setScale(0.5)
        bottomWall.setScale(0.5)
        
        walls.addChild(topWall)
        walls.addChild(bottomWall)
        
        self.addChild(walls)
        
    }
    
    
}
