//
//  PointScreen.swift
//  scenekit_plugin
//
//  Created by Alex on 13.05.2022.
//

class Point {
    public let x: Double
    public let y: Double

    init(pointX: Double, pointY: Double) {
        x = pointX
        y = pointY
    }

    static func initFromParameters(params: Dictionary<String, Any>) -> Point{
        return Point(pointX: (params["x"] as? Double)!, pointY: (params["y"] as? Double)!)
    }
}
