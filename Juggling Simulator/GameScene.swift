//
//  GameScene.swift
//  Juggling Simulator
//
//  Created by Anthony Caligure on 3/25/19.
//  Copyright © 2019 CaligureConciatoriChoy. All rights reserved.
//

/*
For catch change position to glove position and stop moving the ball
*/
import SpriteKit
import GameplayKit

//Testing my branch

class GameScene: SKScene {
    
    let greenBall = SKSpriteNode(imageNamed:"ball1")
    let redBall = SKSpriteNode(imageNamed:"ball2")
    let yellowBall = SKSpriteNode(imageNamed:"ball3")
    
    let leftGlove = SKSpriteNode(imageNamed:"leftGlove")
    let rightGlove = SKSpriteNode(imageNamed:"rightGlove")
    
    var timerCount = Timer()
    
    var gameOver = false
    
    lazy var gameTitle: SKLabelNode = {
        var label = SKLabelNode()
        label.fontName = "Pentagon"
        label.fontSize = 150.0
        label.zPosition = 1
        label.fontColor = SKColor.init(red: 186.0/256.0, green: 49.0/256.0, blue: 33.0/256.0, alpha: 1.0)
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "Juggling Simulator"
        return label
    }()
    
    
    lazy var timer: SKLabelNode = {
        var label = SKLabelNode()
        label.fontName = "Pentagon"
        label.fontSize = 100.0
        label.zPosition = 1
        label.fontColor = SKColor.init(red: 186.0/256.0, green: 49.0/256.0, blue: 33.0/256.0, alpha: 1.0)
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "0 : 0"
        return label
    }()
    
    
    var currentTime = 0
    
    override func didMove(to view: SKView) {
    
        //Create background
        
        let background = SKSpriteNode(imageNamed: "background")
        background.setScale(0.1)
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        
        self.addChild(background)
        
        //Title and timer label
        
        gameTitle.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.95)
        addChild(gameTitle)
        
        timer.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.85)
        addChild(timer)
        
        
        //Create gloves and set position
        
        leftGlove.setScale(0.15)
        leftGlove.position = CGPoint(x: self.size.width * 0.25, y: self.size.height * 0.2)
        leftGlove.zPosition = 1
        
        self.addChild(leftGlove)
        
        rightGlove.setScale(0.15)
        rightGlove.position = CGPoint(x: self.size.width * 0.75, y: self.size.height * 0.2)
        rightGlove.zPosition = 1
        
        self.addChild(rightGlove)
        
        //Create balls and set position
        
        //red
        greenBall.setScale(0.125)
        greenBall.position = CGPoint(x: self.size.width * 0.21, y: self.size.height * 0.2)
        greenBall.zPosition = 2
        
        self.addChild(greenBall)
        
        
        redBall.setScale(0.3)
        redBall.position = CGPoint(x: self.size.width * 0.25, y: self.size.height * 0.2)
        redBall.zPosition = 3
        
        self.addChild(redBall)
        
        yellowBall.setScale(0.25)
        yellowBall.position = CGPoint(x: self.size.width * 0.76, y: self.size.height * 0.2)
        yellowBall.zPosition = 4
        
        self.addChild(yellowBall)
        
    }
    
    func startTimer() {
        
        timerCount = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameScene.updateTime)), userInfo: nil, repeats: true)
        
    }
    
    func updateTime() {
        
        currentTime += 1
        timer.text = "\(currentTime / 60) : \(currentTime % 60)"
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Begin timer
        startTimer()
        
        let moveLeftHandX = SKAction.moveTo(x: self.size.width * 0.30, duration: 0.5)
        let moveLeftHandY = SKAction.moveTo(y: self.size.height * 0.25, duration: 0.5)
        
        let moveLeftHandBackX = SKAction.moveTo(x: self.size.width * 0.25, duration: 0.5)
        let moveLeftHandBackY = SKAction.moveTo(y: self.size.height * 0.2, duration: 0.5)
        
        let moveRightHandX = SKAction.moveTo(x: self.size.width * 0.70, duration: 0.5)
        let moveRightHandY = SKAction.moveTo(y: self.size.height * 0.25, duration: 0.5)
        
        let moveRightHandBackX = SKAction.moveTo(x: self.size.width * 0.75, duration: 0.5)
        let moveRightHandBackY = SKAction.moveTo(y: self.size.height * 0.2, duration: 0.5)
        
        //right seqence moves the ball from the left hand to the right hand
        let moveRight = SKAction.moveTo(x: self.frame.size.width * 0.6, duration: 1.5)
        let moveUp = SKAction.moveTo(y: self.frame.size.height * 0.75, duration: 1.5)
        let moveDown = SKAction.moveTo(y: self.size.height * 0.2, duration: 1.5)
        let moveRighter = SKAction.moveTo(x: self.size.width * 0.75, duration: 1.5)
        let group1 = SKAction.group([moveRight,moveUp])
        let group2 = SKAction.group([moveDown,moveRighter])
        let sequenceRight = SKAction.sequence([group1,group2])

        
        //left sequence moves the ball from the right hand to the left hand
        let moveLeft = SKAction.moveTo(x: self.frame.size.width/2, duration: 1.5)
        let moveDownLeft = SKAction.moveTo(y: self.size.height * 0.2, duration: 1.5)
        let moveLefter = SKAction.moveTo(x: self.size.width * 0.25, duration: 1.5)

        let group3 = SKAction.group([moveLeft,moveUp])
        let group4 = SKAction.group([moveDownLeft,moveLefter])
        let sequenceLeft = SKAction.sequence([group3,group4])
        
        let throwBall = SKAction.group([moveLeftHandX, moveLeftHandY])
        let returnHand = SKAction.group([moveLeftHandBackX, moveLeftHandBackY])
        
        let handSequence = SKAction.sequence([throwBall, returnHand])
        
        let throwBallRight = SKAction.group([moveRightHandX, moveRightHandY])
        let returnHandRight = SKAction.group([moveRightHandBackX, moveRightHandBackY])
        
        let handSequenceRight = SKAction.sequence([throwBallRight, returnHandRight])
        
        for touch in touches {
            
            if(leftGlove.contains(touch.location(in: self))) {
                
                if(greenBall.contains(touch.location(in: self))) {
                    
                    greenBall.run(sequenceRight)
                    leftGlove.run(handSequence)
                }
                
                else if(redBall.contains(touch.location(in: self))) {
                    
                    redBall.run(sequenceRight)
                    leftGlove.run(handSequence)
                }
                
                else if(yellowBall.contains(touch.location(in: self))) {
                    
                    yellowBall.run(sequenceRight)
                    leftGlove.run(handSequence)
                }
                
            }
            
            if(rightGlove.contains(touch.location(in: self))) {
                
                if(greenBall.contains(touch.location(in: self))) {
                    
                    greenBall.run(sequenceLeft)
                    rightGlove.run(handSequenceRight)
                }
                    
                else if(redBall.contains(touch.location(in: self))) {
                    
                    redBall.run(sequenceLeft)
                    rightGlove.run(handSequenceRight)
                }
                    
                else if(yellowBall.contains(touch.location(in: self))) {
                    
                    yellowBall.run(sequenceLeft)
                    rightGlove.run(handSequenceRight)
                }
                
            }
            
        }
        
    }

    
    override func update(_ currentTime:TimeInterval) {
        
        //Game is over, stop timer
        if(gameOver) {
            
            timerCount.invalidate()
            timer.text = "Game Over!"
            //sleep(2)
            let startTemp:StartScene = StartScene(size: self.size)
            startTemp.scaleMode = SKSceneScaleMode.aspectFill
            self.scene?.view?.presentScene(startTemp,transition: SKTransition.doorsCloseHorizontal(withDuration:2.0))
            //abort()
            
        }
        
        //Green and Red check
        if(greenBall.position.x == redBall.position.x && greenBall.position.y == redBall.position.y) {
            
            if(greenBall.position.x == leftGlove.position.x && greenBall.position.y == leftGlove.position.y) {
                
                gameOver = true
            }
            
            else if(greenBall.position.x == rightGlove.position.x && greenBall.position.y == rightGlove.position.y) {
                
                gameOver = true
            }
            
        }
        
        //Green and Yellow check
        if(greenBall.position.x == yellowBall.position.x && greenBall.position.y == yellowBall.position.y) {
            
            if(greenBall.position.x == leftGlove.position.x && greenBall.position.y == leftGlove.position.y) {
                
                gameOver = true
            }
                
            else if(greenBall.position.x == rightGlove.position.x && greenBall.position.y == rightGlove.position.y) {
                
                gameOver = true
            }
            
        }
        
        //Yellow and Red check
        if(yellowBall.position.x == redBall.position.x && yellowBall.position.y == redBall.position.y) {
            
            if(yellowBall.position.x == leftGlove.position.x && yellowBall.position.y == leftGlove.position.y) {
                
                gameOver = true
            }
                
            else if(yellowBall.position.x == rightGlove.position.x && yellowBall.position.y == rightGlove.position.y) {
                
                gameOver = true
            }
            
        }
        
    }
    
}//ends program
