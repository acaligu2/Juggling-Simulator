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
    
    func startTimer(){
        
        timerCount = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameScene.updateTime)), userInfo: nil, repeats: true)
        
    }
    
    func updateTime(){
        
        currentTime += 1
        timer.text = "\(currentTime / 60) : \(currentTime % 60)"
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Begin timer
        startTimer()
        
        //right seqence moves the ball from the left hand to the right hand
        let moveRight = SKAction.moveTo(x: self.frame.size.width * 0.6, duration: 1.0)
        let moveUp = SKAction.moveTo(y: self.frame.size.height * 0.75, duration: 1.0)
        let moveDown = SKAction.moveTo(y: rightGlove.position.y, duration: 1.0)
        let moveRighter = SKAction.moveTo(x: rightGlove.position.x, duration: 1.0)
        let group1 = SKAction.group([moveRight,moveUp])
        let group2 = SKAction.group([moveDown,moveRighter])
        let sequenceRight = SKAction.sequence([group1,group2])

        
        //left sequence moves the ball from the right hand to the left hand
        let moveLeft = SKAction.moveTo(x: self.frame.size.width/2, duration: 1.0)
        let moveDownLeft = SKAction.moveTo(y: leftGlove.position.y, duration: 1.0)
        let moveLefter = SKAction.moveTo(x: leftGlove.position.x, duration: 1.0)

        let group3 = SKAction.group([moveLeft,moveUp])
        let group4 = SKAction.group([moveDownLeft,moveLefter])
        let sequenceLeft = SKAction.sequence([group3,group4])
        
        
        //redBall.run(sequenceRight)//red ball in left hand, throw right
        //redBall.run(sequenceLeft)//red ball in right hand, throw left
        //yellowBall.run(sequenceLeft)//yellow ball in right hand, throw left
        //yellowBall.run(sequenceRight)//yellow ball in left hand, throw right
        greenBall.run(sequenceRight)//green ball in left hand, throw right
        //greenBall.run(sequenceLeft)//green ball in right hand, throw left
    }

    
    override func update(_ currentTime:TimeInterval){
        
        //Game is over, stop timer
        if(gameOver){
            
            timerCount.invalidate()
            
            timer.text = "Game Over!"
            
            //TO-DO: Transition to end screen w/ score and high score
            
        }
        
        let leftSize = leftGlove.size
        let rightSize = leftGlove.size
        
        if(greenBall.position.x < leftGlove.position.x + leftSize.width && greenBall.position.x > leftGlove.position.x - leftSize.width) {
            
            if(greenBall.position.y < leftGlove.position.y + leftSize.height && greenBall.position.y > leftGlove.position.y - leftSize.height) {
                
                //do catch
            }
        }
        
        else if(greenBall.position.x < rightGlove.position.x + rightSize.width && greenBall.position.x > rightGlove.position.x - rightSize.width) {
            
            if(greenBall.position.y < rightGlove.position.y + rightSize.height && greenBall.position.y > rightGlove.position.y - rightSize.height) {
                
                //do catch
            }
        }
        
        else {
            
            
        }
        
        if(yellowBall.position.x < leftGlove.position.x + leftSize.width && yellowBall.position.x > leftGlove.position.x - leftSize.width) {
            
            if(yellowBall.position.y < leftGlove.position.y + leftSize.height && yellowBall.position.y > leftGlove.position.y - leftSize.height) {
                
                //do catch
            }
        }
            
        else if(yellowBall.position.x < rightGlove.position.x + rightSize.width && yellowBall.position.x > rightGlove.position.x - rightSize.width) {
            
            if(yellowBall.position.y < rightGlove.position.y + rightSize.height && yellowBall.position.y > rightGlove.position.y - rightSize.height) {
                
                //do catch
            }
        }
            
        else {
            
            
        }
        
        if(redBall.position.x < leftGlove.position.x + leftSize.width && redBall.position.x > leftGlove.position.x - leftSize.width) {
            
            if(redBall.position.y < leftGlove.position.y + leftSize.height && redBall.position.y > leftGlove.position.y - leftSize.height) {
                
                //do catch
            }
        }
            
        else if(redBall.position.x < rightGlove.position.x + rightSize.width && redBall.position.x > rightGlove.position.x - rightSize.width) {
            
            if(redBall.position.y < rightGlove.position.y + rightSize.height && redBall.position.y > rightGlove.position.y - rightSize.height) {
                
                //do catch
            }
        }
            
        else {
            
            
        }
    }
    
}//ends program
