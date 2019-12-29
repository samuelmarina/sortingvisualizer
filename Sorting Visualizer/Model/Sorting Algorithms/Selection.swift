//
//  Selection.swift
//  Sorting Visualizer
//
//  Created by Samuel Miller on 12/16/19.
//  Copyright © 2019 Samuel Miller. All rights reserved.
//

import UIKit

class Selection{
    var rectGenerator = GenerateRectangles()
    
    //Color that indicates the current minimum value
    func minIndexColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    }
    
    //Color that indicates the ractangle we are comparing the minimum with
    func compareColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }
    
    //Original color
    func returnColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
    
    //Color used to show that a swap between two rectangles is going to happen
    func toSwapColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
    
    func swap(rect: inout Rectangle){
        rect.rectView.frame = rect.toCGRect()
    }
    
    func selectionSort(array2: [Rectangle], view: UIView, navBar: UINavigationItem, firstButton: UIButton, secondButton: UIButton, thirdButton: UIButton){
        var array = array2
        
        //Iteration variables
        var i = 0
        var j = i + 1
        var min = i
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
        guard i <= array.count - 1 else { timer.invalidate() ; return }
            //Select the current minimum rectangle
            self.minIndexColor(rect: array[min])
            
            //Condition to know when all rectangles have been compared
            if (i < array.count - 1){
                //Stopping condition for j
                if (j < array.count){
                    //Change the color of the rectangle we are comparing with
                    self.compareColor(rect: array[j])
                    
                    //If we need to swap
                    if (array[j].height < array[min].height){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            //Return the color of the last minimum
                            self.returnColor(rect: array[min])
                            
                            //Select the new minimum
                            min = j
                            self.minIndexColor(rect: array[min])
                            j += 1
                        })
                        
                    }
                    else{
                        //In case of no swap needed, we just return the color
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            self.returnColor(rect: array[j])
                            j += 1
                        })
                    }
                    
                    
                }
                else{
                    //Mark the two rectangles who are going to be swapped
                    self.toSwapColor(rect: array[i])
                    self.toSwapColor(rect: array[min])
                    
                    //Swap
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                        let temp = array[i].xPos
                        array[i].xPos = array[min].xPos
                        array[min].xPos = temp
                        
                        self.swap(rect: &array[i])
                        self.swap(rect: &array[min])
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                            //Return the color of the last minimum
                            self.returnColor(rect: array[i])
                            
                            //Mark as sorted
                            array[min].rectView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                            
                            //Swap the array values
                            array.swapAt(i, min)
                            
                            //Update iteration variables
                            i += 1
                            j = i + 1
                            min = i
                        })
                        
                    })
                    
                }
            }
            //When we reach the last iteration, the last rectangle is already sorted
            else{
                array[i].rectView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            }
            
            if(i == array.count - 1){
                self.enableButtons(navBar: navBar, firstButton: firstButton, secondButton: secondButton, thirdButton: thirdButton)
            }
            
        }
    }
    
    func enableButtons(navBar: UINavigationItem, firstButton: UIButton, secondButton: UIButton, thirdButton: UIButton) {
        navBar.leftBarButtonItem?.isEnabled = true
        navBar.rightBarButtonItem?.isEnabled = true
        firstButton.isEnabled = true
        secondButton.isEnabled = true
        thirdButton.isEnabled = true
    }
}
