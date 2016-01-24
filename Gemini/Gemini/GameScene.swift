//
//  GameScene.swift
//  Gemini
//
//  Created by jgh on 16/1/24.
//  Copyright (c) 2016年 jgh. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var firstHero:SKSpriteNode!
    var firstHeroCKPosition:CGPoint!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let planeTexture = SKTexture(imageNamed: "Spaceship")
        let plane = SKSpriteNode(texture: planeTexture)
        plane.position = CGPointMake(size.width * 0.5, size.height * 0.5)
        plane.setScale(0.1)
        self.firstHero = plane
        addChild(plane)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        print("began")
        self.firstHeroCKPosition = touches.first!.locationInNode(self)

        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("moved")
        let touch = touches.first
        let currentTouch = touch!.locationInNode(self)
        
        let dx = currentTouch.x - self.firstHeroCKPosition.x
        let dy = currentTouch.y - self.firstHeroCKPosition.y
        self.firstHero.position.x += dx
        self.firstHero.position.y += dy
        self.firstHeroCKPosition = currentTouch
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
