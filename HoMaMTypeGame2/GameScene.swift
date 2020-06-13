//
//  GameScene.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-12.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    

    
    override func didMove(to view: SKView) {
//        let creature = Creature(myParam : 20, color: UIColor.red, size: CGSize(width: 100, height: 100))
//        creature.position = CGPoint.zero
//        addChild(creature)
        
        
        let creature = CreatureManager.instance.CreateNewCreature(creatureGlossary: .GHOST, creatureCount: 5)
        creature.position = CGPoint(x:-200, y: 0)
        addChild(creature)
        
        let creature2 = CreatureManager.instance.CreateNewCreature(creatureGlossary: .SPIDER, creatureCount: 10)
        creature2.position = CGPoint(x:200, y: 0)
        addChild(creature2)
        
        let creature3 = CreatureManager.instance.CreateNewCreature(creatureGlossary: .EFREET, creatureCount: 7)
        creature3.position = CGPoint(x:0, y: 0)
        addChild(creature3)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        CreatureManager.instance.IterateAllAnimations()
    }
    
   
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        CreatureManager.instance.UpdateAllActiveCreatures()
    }
}
