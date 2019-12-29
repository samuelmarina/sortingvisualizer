//
//  Rectangle.swift
//  Sorting Visualizer
//
//  Created by Samuel Miller on 12/14/19.
//  Copyright © 2019 Samuel Miller. All rights reserved.
//

import UIKit

struct Rectangle {
    let height: Int
    let width: Int
    var xPos: Int
    var yPos = 0
    var rectView: UIView
    
    func toCGRect() -> CGRect {
        return CGRect(x: xPos, y: yPos, width: width, height: height)
    }
}
