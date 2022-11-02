//
//  GameScene.swift
//  AngryBirdsClone
//
//  Created by Berkay on 17.10.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameStarted = false // to decide that the game has started or not?
    var originalBirdPosition : CGPoint? // to impulse force relatively
    
    var score : Int32 = 0
    var scoreLabel = SKLabelNode()
    
    var ground = SKSpriteNode()
    var bird = SKSpriteNode()
    
    var cactus1 = SKSpriteNode()
    var cactus2 = SKSpriteNode()
    var cactus3 = SKSpriteNode()
    var cactus4 = SKSpriteNode()
    
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var box6 = SKSpriteNode()
    var box7 = SKSpriteNode()
    var box8 = SKSpriteNode()
    var box9 = SKSpriteNode()
    var box10 = SKSpriteNode()
    
    var birdTexture = SKTexture(imageNamed: "bird")
    
    enum ColliderType: UInt32 {
        
        case Bird = 1
        case Box = 2
        case Cactus = 4
        case BirdGotHit = 8
        
        
    }
    
    
    override func didMove(to view: SKView) {
        
        // General Physic
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.contactDelegate = self
        
        // Score Label
        scoreLabel.zPosition = 0
        scoreLabel.text = String(score)
        scoreLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1) // black colour
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 200
        scoreLabel.position = CGPoint(x: 0, y: 450)
        addChild(scoreLabel)
        
        
        // Adding Ground with Code
        // ground = childNode(withName: "ground") as! SKSpriteNode
        let groundTexture = SKTexture(imageNamed: "ground")
        ground = SKSpriteNode(texture: groundTexture)
        let groundSize = CGSize(width: 3072, height: 192)
        ground.position = CGPoint(x: 0, y: -672)
        ground.physicsBody = SKPhysicsBody(texture: groundTexture, size: groundSize)
        ground.physicsBody?.affectedByGravity = true
        ground.physicsBody?.isDynamic = true
        ground.physicsBody?.allowsRotation = false
        
        self.addChild(ground)
        
        
        /*
        // BirdGotHit
        let texture = SKTexture(imageNamed: "birdGotHit")
        birdGotHit = SKSpriteNode(texture: texture)
        birdGotHit.position = CGPoint(x: -1500, y: -1500)
        birdGotHit.size = CGSize(width: 100, height: 100)
        birdGotHit.zPosition = 0
        birdGotHit.physicsBody?.affectedByGravity = true
        birdGotHit.physicsBody?.contactTestBitMask = ColliderType.BirdGotHit.rawValue
        birdGotHit.physicsBody?.collisionBitMask = ColliderType.BirdGotHit.rawValue
        birdGotHit.physicsBody?.categoryBitMask = ColliderType.BirdGotHit.rawValue
        */
        
        // Bird with code
        
        // bird = childNode(withName: "bird") as! SKSpriteNode
        
        bird = SKSpriteNode(texture: birdTexture)
        let birdSize = CGSize(width: 250, height: 250)
        bird.position = CGPoint(x: -1120, y: -120)
        bird.physicsBody = SKPhysicsBody(circleOfRadius: 250)
        bird.scale(to: birdSize)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.allowsRotation = true
        bird.physicsBody?.isDynamic = true
        bird.physicsBody!.mass = 0.1
        self.addChild(bird)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        originalBirdPosition = bird.position
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Cactus.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.zPosition = 0
        
        //cactuses
        
        cactus1 = childNode(withName: "cactus1") as! SKSpriteNode
        let cactusTexture = SKTexture(imageNamed: "cactus")
        cactus1 = SKSpriteNode(texture: cactusTexture)
        let cactus1Size = CGSize(width: 150, height: 170)
        cactus1.physicsBody?.mass = 20
        cactus1.physicsBody = SKPhysicsBody(rectangleOf: cactus1Size)
        cactus1.physicsBody?.isDynamic = false
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        cactus1.zPosition = 0
        
        cactus2 = childNode(withName: "cactus2") as! SKSpriteNode
        let cactus2Texture = SKTexture(imageNamed: "cactus2")
        let cactus2Size = CGSize(width: 185, height: 240)
        cactus2.physicsBody?.mass = 20
        cactus2.physicsBody = SKPhysicsBody(rectangleOf: cactus2Size)
        cactus2.physicsBody?.isDynamic = false
        cactus2.zPosition = 0
        
        cactus3 = childNode(withName: "cactus3") as! SKSpriteNode
        let cactus3Texture = SKTexture(imageNamed: "cactus3")
        let cactus3Size = CGSize(width: 110, height: 150)
        cactus3.physicsBody?.mass = 20
        cactus3.physicsBody = SKPhysicsBody(rectangleOf: cactus3Size)
        cactus3.physicsBody?.isDynamic = false
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        cactus3.zPosition = 0
        
        cactus4 = childNode(withName: "cactus4") as! SKSpriteNode
        let cactus4Texture = SKTexture(imageNamed: "cactus4")
        let cactus4Size = CGSize(width: 185, height: 390)
        cactus4.physicsBody?.mass = 20
        cactus4.physicsBody = SKPhysicsBody(rectangleOf: cactus4Size)
        cactus4.physicsBody?.isDynamic = false
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        cactus4.zPosition = 0
         
        
        
        // Boxes
        
        let BoxSize = CGSize(width: 140, height: 131)
        let boxTexture = SKTexture(imageNamed: "box")
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.mass = 0.001
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.isDynamic = true
        box1.physicsBody = SKPhysicsBody(rectangleOf: BoxSize)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        box1.zPosition = 0
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.mass = 0.001
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody = SKPhysicsBody(rectangleOf: BoxSize)
        box2.physicsBody?.isDynamic = true
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        box2.zPosition = 0
    
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.mass = 0.001
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody = SKPhysicsBody(rectangleOf: BoxSize)
        box3.physicsBody?.isDynamic = true
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        box3.zPosition = 0
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.mass = 0.001
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody = SKPhysicsBody(rectangleOf: BoxSize)
        box4.physicsBody?.isDynamic = true
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        box4.zPosition = 0
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.mass = 0.001
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody = SKPhysicsBody(rectangleOf: BoxSize)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        box5.zPosition = 0
        
        box6 = childNode(withName: "box6") as! SKSpriteNode
        box6.physicsBody?.affectedByGravity = true
        box6.physicsBody?.mass = 0.001
        box6.physicsBody?.allowsRotation = true
        box6.physicsBody = SKPhysicsBody(rectangleOf: BoxSize)
        box6.physicsBody?.isDynamic = true
        box6.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        box6.zPosition = 0
        
        box7 = childNode(withName: "box7") as! SKSpriteNode
        box7.physicsBody?.affectedByGravity = true
        box7.physicsBody?.mass = 0.001
        box7.physicsBody?.allowsRotation = true
        box7.physicsBody = SKPhysicsBody(rectangleOf: BoxSize)
        box7.physicsBody?.isDynamic = true
        box7.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        box7.zPosition = 0
        
        box8 = childNode(withName: "box8") as! SKSpriteNode
        box8.physicsBody?.affectedByGravity = true
        box8.physicsBody?.mass = 0.001
        box8.physicsBody?.allowsRotation = true
        box8.physicsBody = SKPhysicsBody(rectangleOf: BoxSize)
        box8.physicsBody?.isDynamic = true
        box8.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        box8.zPosition = 0
        
        box9 = childNode(withName: "box9") as! SKSpriteNode
        box9.physicsBody?.affectedByGravity = true
        box9.physicsBody?.mass = 0.001
        box9.physicsBody?.allowsRotation = true
        box9.physicsBody = SKPhysicsBody(rectangleOf: BoxSize)
        box9.physicsBody?.isDynamic = true
        box9.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        box9.zPosition = 0
    
        box10 = childNode(withName: "box10") as! SKSpriteNode
        box10.physicsBody?.affectedByGravity = true
        box10.physicsBody?.mass = 0.001
        box10.physicsBody?.allowsRotation = true
        box10.physicsBody = SKPhysicsBody(rectangleOf: BoxSize)
        box10.physicsBody?.isDynamic = true
        box10.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        box10.zPosition = 0
    
        
        
    
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            score = score + 1
            scoreLabel.text = String(score)
            
        }
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
      
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        // Moving the Bird with touching the screen.
        
        if gameStarted == false {                               // controling the move
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)    // getting the location
                let touchNodes = nodes(at: touchLocation)
                if touchNodes.isEmpty == false {                // controlling the location
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode { // casting the node as SKSpriteNode
                            if sprite == bird {                 // controlling is sprite class equal to bird class
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {                               // controling the move
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)    // getting the location
                let touchNodes = nodes(at: touchLocation)
                if touchNodes.isEmpty == false {                // controlling the location
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode { // casting the node as SKSpriteNode
                            if sprite == bird {                 // controlling is sprite class equal to bird class
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if gameStarted == false {                               // controling the move
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)    // getting the location
                let touchNodes = nodes(at: touchLocation)
                if touchNodes.isEmpty == false {                // controlling the location
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode { // casting the node as SKSpriteNode
                            if sprite == bird {                 // controlling is sprite class equal to bird class
                                bird.physicsBody?.affectedByGravity = true
                                let dx = -(touchLocation.x - originalBirdPosition!.x)
                                let dy = -(touchLocation.y - originalBirdPosition!.y)
                                let impulseVector = CGVector(dx: dx, dy: dy)
                                bird.physicsBody?.applyImpulse(impulseVector)
                                gameStarted = true
                                
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
        if let birdSpeed = bird.physicsBody?.angularVelocity {
            
            if birdSpeed <= 0.1 && (bird.physicsBody?.velocity.dx)! <= 0.1 && (bird.physicsBody?.velocity.dy)! <= 0.1 && gameStarted == true {
            
                
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.position = originalBirdPosition!
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.affectedByGravity = false
                score = 0
                scoreLabel.text = String(score)
                
                
                gameStarted = false
                
                
            }
        }
    }
}
