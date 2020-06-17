//
//  CGSize&Extensions.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-15.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import CoreGraphics

func * (point1: CGSize, point2: CGSize) -> CGSize{
    return CGSize(width: point1.width * point2.width, height: point1.height * point2.height)
}

func *= (point1: inout CGSize, point2: CGSize){
    point1 = point1 * point2
}

func * (point1: CGSize, scalar: CGFloat) -> CGSize{
    return CGSize(width: point1.width * scalar, height: point1.height * scalar)
}

func *= (point1: inout CGSize, scalar:  CGFloat){
    point1 = point1 * scalar
}

