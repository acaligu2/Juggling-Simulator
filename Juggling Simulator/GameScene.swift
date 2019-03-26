//
//  GameScene.swift
//  Juggling Simulator
//
//  Created by Anthony Caligure on 3/25/19.
//  Copyright © 2019 CaligureConciatoriChoy. All rights reserved.
//

import SpriteKit
import GameplayKit

//Testing my branch

class GameScene: SKScene {
    
    let ball1 = SKSpriteNode(imageNamed:"ball1")
    let ball2 = SKSpriteNode(imageNamed:"ball2")
    let ball3 = SKSpriteNode(imageNamed:"ball3")
    
    let glove1 = SKSpriteNode(imageNamed:"leftGlove")
    let glove2 = SKSpriteNode(imageNamed:"rightGlove")
    
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
        
        
        //Create gloves and set position
        
        glove1.setScale(0.1)
        glove1.position = CGPoint(x: self.size.width * 0.25, y: self.size.height * 0.2)
        glove1.zPosition = 1
        
        self.addChild(glove1)
        
        glove2.setScale(0.1)
        glove2.position = CGPoint(x: self.size.width * 0.75, y: self.size.height * 0.2)
        glove2.zPosition = 1
        
        self.addChild(glove2)
        
        //Create balls and set position
        
        ball1.setScale(0.125)
        ball1.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.75)
        ball1.zPosition = 2
        
        self.addChild(ball1)
        
        ball2.setScale(0.3)
        ball2.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        ball2.zPosition = 2
        
        self.addChild(ball2)
        
        ball3.setScale(0.25)
        ball3.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.25)
        ball3.zPosition = 2
        
        self.addChild(ball3)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}
