//
//  StartScene.swift
//  Juggling Simulator
//
//  Created by Bradley Choy on 4/3/19.
//  Copyright © 2019 CaligureConciatoriChoy. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartScene:SKScene{
    override func didMove(to view:SKView){
        let start = SKSpriteNode(imageNamed:"start")
        start.setScale(1.0)
        start.size = self.size
        start.position = CGPoint(x:self.size.width/2,y:self.size.height/2)
        start.zPosition = 1
        
        
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "click to enter"
        myLabel.fontSize = 65
        myLabel.position = CGPoint(x:self.frame.midX,y:self.frame.midY)
        myLabel.zPosition = 2
        self.addChild(myLabel)
        self.addChild(start)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startTemp:GameScene = GameScene(size: self.size)
        startTemp.scaleMode = SKSceneScaleMode.aspectFill
        self.scene?.view?.presentScene(startTemp,transition: SKTransition.doorsCloseHorizontal(withDuration:2.0))
    }
    
}
