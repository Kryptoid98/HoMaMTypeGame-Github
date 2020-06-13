//
//  Creature.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-12.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import SpriteKit

enum eCreatureStates: Int{
    case ATTACK = 0
    case DEATH = 1
    case HIT = 2
    case IDLE = 3
    case WALK = 4
    
}

class Creature : SKNode, Entity{
    var animationNames = ["Attack", "Death", "Hit", "Idle", "Walk"] // This could be in the Animatable class
    var animations: [SKAction] = []
    var animState : eCreatureStates = .IDLE
    
    var creatureData : CreatureData
    
    var spriteNode : SKSpriteNode?
    let countLabel = SKLabelNode(text: "0")
    
    required init(creatureData : CreatureData, creatureCount : Int) {
        self.creatureData = creatureData
        super.init()
        
        //Set up node
        self.position = CGPoint.zero
        
        //Set up sprite node
        let defaultTexture = SKTexture(imageNamed: creatureData.name + "Idle(Frame 1)")
        spriteNode = SKSpriteNode(texture: defaultTexture, color: UIColor.red, size: CGSize(width: 100, height: 100))//defaultTexture.size())
        
        for i in 0..<animationNames.count{
            CreateAnimation(startName: creatureData.name + animationNames[i] + "(Frame ", endName: ")")
        }
        
        self.addChild(spriteNode!)
        spriteNode?.run(animations[animState.rawValue])
        
        
        //Set up Label
        countLabel.fontSize = 30
        countLabel.text = String(creatureCount)
        countLabel.color = UIColor.white
        countLabel.position = CGPoint(x: (spriteNode?.frame.minX)!, y: (spriteNode?.frame.minY)!)
        countLabel.zPosition = 3
        addChild(countLabel)
        
        //run(SKAction.move(to: CGPoint(x:100, y:100), duration: 3))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use Init()")
    }
    
    func Update() {
       //print (spriteNode)
    }
    
    public func IterateAnimation(){
        //VERY TEMPORARY METHOD DEFINITION
        if(animState == .ATTACK){ animState = .DEATH}
        else if(animState == .DEATH){ animState = .HIT}
        else if(animState == .HIT){ animState = .IDLE}
        else if(animState == .IDLE){ animState = .WALK}
        else if(animState == .WALK){ animState = .ATTACK}
        
        if(spriteNode?.hasActions() != nil){spriteNode?.removeAllActions()}
        spriteNode?.run(animations[animState.rawValue])
    }
}

extension Creature: Animatable {}
//class Creature : SKSpriteNode {
//
//    required init(myParam : Int, color : UIColor, size: CGSize) {
//        super.init(texture: nil, color: color, size: size)
//        print(myParam)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("Use Init()")
//    }
//
//}
