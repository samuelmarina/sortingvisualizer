//
//  GenerateRectangles.swift
//  Sorting Visualizer
//
//  Created by Samuel Miller on 12/14/19.
//  Copyright © 2019 Samuel Miller. All rights reserved.
//

import UIKit
struct GenerateRectangles {
    //Starting X Position
    var xPos = 0
    
    //Generation of an array with all the random sized rectangles
    mutating func allTheRectangles(quantity: Int, view: UIView) -> [Rectangle]{
        var rectangleArray = [Rectangle]()
        for i in 1...quantity {
            let rect = randomRectangle(tag: i)
            addRectangleToView(view: view, rect: rect)
            rectangleArray.append(rect)
            xPos += 40
        }
        xPos = 0
        return rectangleArray
    }
    
    //Generation of a random sized rectangle
    func randomRectangle(tag: Int) -> Rectangle {
        let randomHeight = Int.random(in: 30 ..< 150)
        let rectView = createRectView(xPos: xPos, yPos: 0, width: 30, height: randomHeight, tag: tag)
        rectView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        let rectangle = Rectangle(height: randomHeight, width: 30, xPos: xPos, rectView: rectView)
        
        return rectangle
    }
    
    //Generation of the view of a rectangle
    func createRectView(xPos: Int, yPos: Int, width: Int, height: Int, tag: Int) -> UIView {
        let rectFrame = CGRect(x:CGFloat(xPos), y:CGFloat(yPos), width:CGFloat(width), height:CGFloat(height))
        
        let rectView = UIView(frame: rectFrame)
        rectView.tag = tag
        
        return rectView
    }
    
    //Adding the rectangle view to display
    func addRectangleToView(view: UIView, rect: Rectangle){
        view.addSubview(rect.rectView)
    }
    
    //Removing the rectangle view off the display
    func removeRectangleView(view: UIView, tag: Int){
        view.viewWithTag(tag)?.removeFromSuperview()
    }
    
    //Removing rectangles from display and values from the array
    func removeAllRectangles(rectArray: inout [Rectangle], view: UIView){
        while (rectArray.count > 0){
            self.removeRectangleView(view: view, tag: rectArray[0].rectView.tag)
            rectArray.remove(at: 0)
        }
    }
    
    //After removing, we recreate the rectangle and add it to the view
    func regenerateRectangleView(rect: inout Rectangle, view: UIView){
        let tempView = createRectView(xPos: rect.xPos, yPos: rect.yPos, width: rect.width, height: rect.height, tag: rect.rectView.tag)
//        tempView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        rect.rectView = tempView
        addRectangleToView(view: view, rect: rect)
        
    }
}
