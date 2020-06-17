//
//  CreatureData.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-12.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import SpriteKit

class CreatureData{
    var name : String
    var moveDistance: Int
    var speed : Int
    // var baseHealth
    
    init(name: String, moveDistance : Int, speed: Int){
        self.name = name
        self.moveDistance = moveDistance
        self.speed = speed
    }
}
