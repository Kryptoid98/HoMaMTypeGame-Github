//
//  Extensions.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-12.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import SpriteKit

extension SKTexture{
    convenience init(pixelImagedNamed: String){
        self.init(imageNamed: pixelImagedNamed)
        self.filteringMode = .nearest
    }
}
