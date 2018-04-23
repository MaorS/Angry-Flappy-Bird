//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Maor Shamsian on 23/04/2018.
//  Copyright © 2018 Maor Shamsian. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene{
    
    private var ground = SKSpriteNode()
    private var bird = SKSpriteNode()
    private var walls = SKNode()
    private var scoreLabel = SKLabelNode(fontNamed: "angrybirds-regular")
    
    var moveAndRemove = SKAction()
    let gameModel = GameModel()
    
    override func didMove(to view: SKView) {
        
        self.createScene()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameModel.gameStarted{
            
            if !gameModel.isDead{
                // on bird touch
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
            }
        }else{
            gameModel.gameStarted = true
            bird.physicsBody?.affectedByGravity = true
            
            let spawn = SKAction.run {
                self.createWalls()
            }
            
            let delay = SKAction.wait(forDuration: 3)
            
            let spawnDelay = SKAction.sequence([spawn,delay])
            let spawnDelayReapat = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayReapat)
            
            let distance = CGFloat(self.frame.width + walls.frame.width)
            let movePipes = SKAction.moveBy(x: -distance, y: 0, duration: TimeInterval(0.02 * distance))
            let removePipes = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([movePipes,removePipes])
            
        }
    }
    
    private func addScoreLabel(){
        scoreLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.5)
        scoreLabel.zPosition = 5
        scoreLabel.text = String(describing: gameModel.score)
        self.addChild(scoreLabel)
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
        bird.physicsBody?.contactTestBitMask = Physics.ground | Physics.wall | Physics.score
        bird.physicsBody?.affectedByGravity = false
        // effect by hit
        bird.physicsBody?.isDynamic = true
        
        bird.zPosition = 2
        self.addChild(bird)
        
    }
    
    private func createWalls(){
        self.walls = SKNode()
        
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 1, height: 200)
        scoreNode.position = CGPoint(x: self.frame.width, y: self.frame.height / 2)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = Physics.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = Physics.bird
        
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
        
        let randomPosition = CGFloat.random(min: -200, max: 200)
        walls.position.y = walls.position.y + randomPosition
        walls.addChild(scoreNode)
        
        walls.run(moveAndRemove)
        self.addChild(walls)
        
    }
    
    func createScene(){
        self.physicsWorld.contactDelegate = self
        self.addGround()
        self.addBird()
        self.addScoreLabel()
    }
    
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        gameModel.resetData()
        createScene()
    }
    
    
}

extension GameScene : SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        // Pass wall
        if firstBody.categoryBitMask == Physics.score && secondBody.categoryBitMask == Physics.bird || firstBody.categoryBitMask == Physics.bird && secondBody.categoryBitMask == Physics.score {
            
            gameModel.score += 1
            scoreLabel.text = String(describing: gameModel.score)
        }
        
        // Hit wall
        if firstBody.categoryBitMask == Physics.bird && secondBody.categoryBitMask == Physics.wall || firstBody.categoryBitMask == Physics.wall && secondBody.categoryBitMask == Physics.bird{
            gameModel.isDead = true
        }
        
        
    }
}
