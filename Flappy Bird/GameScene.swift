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
        
        // on bird touch
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
        
        
    }
    
    private func addGround(){
        ground = SKSpriteNode(imageNamed: "image_ground")
        ground.setScale(0.5)
        let groundX = self.frame.width / 2
        let groundY = ground.frame.height / 2
        ground.position = CGPoint(x: groundX, y: groundY)
        
        // Physics Body:
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.categoryBitMask = Physics.ground
        ground.physicsBody?.collisionBitMask = Physics.bird
        ground.physicsBody?.contactTestBitMask = Physics.bird
        ground.physicsBody?.affectedByGravity = false
        
        // unmoving on hit
        ground.physicsBody?.isDynamic = false
        
        ground.zPosition = 3
        self.addChild(ground)
    }
    
    func addBird(){
        bird = SKSpriteNode(imageNamed: "image_bird")
        bird.size = CGSize(width: 60, height: 60)
        let birdX = self.frame.width / 2 - bird.frame.width
        let birdY = self.frame.height / 2
        bird.position = CGPoint(x: birdX, y: birdY)
        
        // Physics Body:
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height/2)
        bird.physicsBody?.categoryBitMask = Physics.bird
        bird.physicsBody?.collisionBitMask = Physics.ground | Physics.wall
        bird.physicsBody?.contactTestBitMask = Physics.ground | Physics.wall
        bird.physicsBody?.affectedByGravity = true
        // effect by hit
        bird.physicsBody?.isDynamic = true
        
        bird.zPosition = 2
        self.addChild(bird)
        
    }
    
    private func createWalls(){
        let walls = SKNode()
        let topWall = SKSpriteNode(imageNamed: "image_wall")
        let bottomWall = SKSpriteNode(imageNamed: "image_wall")
        
        topWall.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 + 350)

        bottomWall.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 - 350)
        
        topWall.setScale(0.5)
        bottomWall.setScale(0.5)
        
        // Physics Body:

        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = Physics.wall
        topWall.physicsBody?.collisionBitMask = Physics.bird
        topWall.physicsBody?.contactTestBitMask = Physics.bird
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        bottomWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        bottomWall.physicsBody?.categoryBitMask = Physics.wall
        bottomWall.physicsBody?.collisionBitMask = Physics.bird
        bottomWall.physicsBody?.contactTestBitMask = Physics.bird
        bottomWall.physicsBody?.isDynamic = false
        bottomWall.physicsBody?.affectedByGravity = false
        
        
        walls.addChild(topWall)
        walls.addChild(bottomWall)
        
        walls.zPosition = 1
        
        self.addChild(walls)
        
    }
    
    
}
