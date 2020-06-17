//
//  CGPoint&Extensions.swift
//  HoMaMTypeGame2
//
//  Created by Scott Vander Pryt on 2020-06-14.
//  Copyright © 2020 Scott Vander Pryt. All rights reserved.
//

import CoreGraphics

func + (Point1: CGPoint, Point2: CGPoint) -> CGPoint{
    return CGPoint(x: Point1.x + Point2.x, y: Point1.y + Point2.y)
}

//Inout is exactly like passing by reference
//Were able to add the CGPoints together here because of the overload above
func += (Point1: inout CGPoint, Point2: CGPoint){
    Point1 = Point1 + Point2
}

func - (point1: CGPoint, point2: CGPoint) -> CGPoint{
    return CGPoint(x: point1.x - point2.x, y: point1.y - point2.y )
}

func -= (point1: inout CGPoint, point2: CGPoint){
    point1 = point1 - point2
}

func * (point1: CGPoint, point2: CGPoint) -> CGPoint{
    return CGPoint(x: point1.x * point2.x, y: point1.y * point2.y)
}

func *= (point1: inout CGPoint, point2: CGPoint){
    point1 = point1 * point2
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint{
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func *= (point: inout CGPoint, scalar: CGFloat){
    point = point * scalar
}

func / (point1: CGPoint, point2: CGPoint) -> CGPoint{
    return CGPoint(x: point1.x / point2.x, y: point1.y / point2.y)
}

func /= (point1: inout CGPoint, point2: CGPoint){
    point1 = point1 / point2
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint{
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

func /= (point: inout CGPoint, scalar: CGFloat){
    point = point / scalar
}

extension CGPoint{
    func Length() -> CGFloat{
        return sqrt(x*x + y*y)
    }
    
    func Normalized() -> CGPoint {
        return self / Length()
    }
    
    var angle: CGFloat{
        return atan2(y,x)
    }
}
