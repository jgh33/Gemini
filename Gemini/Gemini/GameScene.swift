//
//  GameScene.swift
//  Gemini
//
//  Created by jgh on 16/1/24.
//  Copyright (c) 2016年 jgh. All rights reserved.
//

import SpriteKit
import CoreMotion
let ww = UIScreen.mainScreen().bounds.width
let hh = UIScreen.mainScreen().bounds.height

class GameScene: SKScene {
    
    var firstHero:SKSpriteNode!
    var firstHeroCKPosition:CGPoint!
    
    var secondHero:SKSpriteNode!
//    var speedX:UIAccelerationValue=0
//    var speedY:UIAccelerationValue=0
    var motionManager = CMMotionManager()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let planeTexture = SKTexture(imageNamed: "Spaceship")
        let plane1 = SKSpriteNode(texture: planeTexture)
        plane1.setScale(0.1)
        plane1.position = CGPointMake(size.width * 0.5, size.height * 0.5)
        
        self.firstHero = plane1
        addChild(plane1)
        
        

        let plane2 = SKSpriteNode(texture: planeTexture)
        plane2.position = CGPointMake(size.width * 0.5, size.height * 0.3)
        plane2.setScale(0.1)
        self.secondHero = plane2
        addChild(plane2)
        
        motionManager.accelerometerUpdateInterval = 1/60
        
        if(motionManager.accelerometerAvailable)
        {
            
            let queue = NSOperationQueue.currentQueue()
            motionManager.startAccelerometerUpdatesToQueue(queue!, withHandler: {(accelerometerData : CMAccelerometerData?, error : NSError?) in
             
                //动态设置第二战机位置
//                self.speedX += accelerometerData!.acceleration.x
//                self.speedY += accelerometerData!.acceleration.y
                var posX = self.secondHero.position.x + CGFloat(accelerometerData!.acceleration.x) * 15
                var posY = self.secondHero.position.y + CGFloat(accelerometerData!.acceleration.y) * 15
                
                print(accelerometerData!.acceleration)
                
                //碰到边框后的反弹处理
                if posX < 0 {
                    posX = 0
//                    self.speedX = 0
                }else if (posX > ww) {
                    posX = ww
//                    self.speedX = 0
                }
                
                if ( posY < 0 ){
                    posY = 0
                    //碰到上面的边框不反弹
//                    self.speedY = 0
                } else if posY > hh{
                    posY = hh
                    //碰到下面的边框以1.5倍的速度反弹
//                    self.speedY = 0
                }
                self.secondHero.position = CGPointMake(posX, posY)
                
            })
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        print("began")
        print("\(ww)")
        print("\(hh)")
        self.firstHeroCKPosition = touches.first!.locationInNode(self)

        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("moved")
        let touch = touches.first
        let currentTouch = touch!.locationInNode(self)
        
        let dx = currentTouch.x - self.firstHeroCKPosition.x
        let dy = currentTouch.y - self.firstHeroCKPosition.y
        
        if((self.firstHero.position.x + dx) < 0){
            self.firstHero.position.x = 0
        }else if ((self.firstHero.position.x + dx) > ww){
            self.firstHero.position.x = ww
        }else{
            self.firstHero.position.x += dx
        }
        
        
        if((self.firstHero.position.y + dy) < 0){
            self.firstHero.position.y = 0
        }else if ((self.firstHero.position.y + dy) > hh){
            self.firstHero.position.y = hh
        }else{
            self.firstHero.position.y += dy
        }
        
        
//        self.firstHero.position.x += dx
//        self.firstHero.position.y += dy
        self.firstHeroCKPosition = currentTouch
        
        print(self.firstHero.position)
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
