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

class Creature : SKSpriteNode, Entity{
    var animationNames = ["Attack", "Death", "Hit", "Idle", "Walk"] // This could be in the Animatable class
    var animations: [SKAction] = []
    var animState : eCreatureStates = .IDLE
    
    var creatureData : CreatureData
    var creatureCount : Int
    
    var tileCoords = TileCoords(column: 0, row: 0) //These are just default values
    var tileDefinition : SKTileDefinition?
    
    let countLabel = SKLabelNode(text: "0")
    
    required init(creatureData : CreatureData, creatureCount : Int, tileCoords: TileCoords, tileDefinition : SKTileDefinition, owningPlayer: Player) {
        
        self.creatureData = creatureData
        self.tileCoords = tileCoords
        self.tileDefinition = tileDefinition
        self.creatureCount = creatureCount
        let defaultTexture = SKTexture(imageNamed: creatureData.name + "Idle(Frame 1)")
        
        super.init(texture: defaultTexture, color: UIColor.clear, size: defaultTexture.size() * 1.25)
        
        self.name = creatureData.name
        anchorPoint = CGPoint(x: 0.5, y: 0)
        zPosition = Constants.creatureZOrder
        
            
        for i in 0..<animationNames.count{
            let startName = creatureData.name + animationNames[i] + "(Frame "
            if(animationNames[i] == "Idle" || animationNames[i] == "Walk"){
                CreateAnimation(startName: startName, endName: ")", isLooping: true)
            }else { CreateAnimation(startName: startName, endName: ")", isLooping: false) }
        }
        
        run(animations[animState.rawValue], withKey: "animation")
        
        
        //Set up Label
        countLabel.fontSize = 30
        countLabel.text = String(creatureCount)
        countLabel.color = UIColor.white
        countLabel.position = CGPoint(x: frame.minX, y: frame.minY)
        countLabel.zPosition = Constants.creatureZOrder + 1
        addChild(countLabel)
        
        //run(SKAction.move(to: CGPoint(x:100, y:100), duration: 3))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use Init()")
    }
    
    public func MoveToNewGridspot(position : CGPoint, scene : SKScene){
        removeAction(forKey: "animation")
        animState = .WALK
        run(animations[animState.rawValue])
        
        let move = SKAction.move(to: position, duration: 2)
        run(SKAction.sequence([move])){
            self.animState = .IDLE
            self.run(self.animations[self.animState.rawValue])
        }
        
    }
    
    func Update() {
       //print (spriteNode)
        //print(action(forKey: "animation"))
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
