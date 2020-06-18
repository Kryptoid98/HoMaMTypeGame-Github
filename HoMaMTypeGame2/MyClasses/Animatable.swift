//
//  Animatable.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-12.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import SpriteKit



protocol Animatable : class{
    var animations : [SKAction]  {get set}
    //var atlas : SKTextureAtlas {get set}
}

extension Animatable{
    func CreateAnimation(startName: String, endName : String, isLooping : Bool){

        var texArray : [SKTexture] = []
        for i in 1...4{
            let name = startName + "\(i)" + endName
            //print(name)
            texArray.append(SKTexture(pixelImagedNamed: name))
        }
        
        var newAnimation : SKAction
        
        if isLooping {
            newAnimation = SKAction.repeatForever(SKAction.animate(with: texArray, timePerFrame: 0.2))
        }
        else {
            newAnimation = SKAction.animate(with: texArray, timePerFrame: 0.2)
        }
        
        //let newAnimation = SKAction.animate(with: texArray, timePerFrame: 0.2)
        animations.append(newAnimation)
    }
}

//textureAtlas = SKTextureAtlas(named: "Player")
//
//for i in 2...textureAtlas.textureNames.count{ //starting at 2 cuz Player 1 is teh idle
//    let name = "Player \(i)"
//    //playerAnimation.append(SKTexture(imageNamed: name))
//    playerAnimation.append(textureAtlas.textureNamed(name))
//}
//
//animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false) //restore means return to idle state i guess
