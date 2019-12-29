//
//  BubbleSort.swift
//  Sorting Visualizer
//
//  Created by Samuel Miller on 12/16/19.
//  Copyright © 2019 Samuel Miller. All rights reserved.
//

import UIKit


class BubbleSort {
    var rectGenerator = GenerateRectangles()
    var time = 1.0
    
    //Change color
    func changeRectColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }
    
    //Swap color
    func sortRectColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
    
    //Original color
    func returnRectColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
    
    func swap(rect: inout Rectangle){
        rect.rectView.frame = rect.toCGRect()
    }
    
    func bubbleSort(array2: [Rectangle], view: UIView, navBar: UINavigationItem, firstButton: UIButton, secondButton: UIButton, thirdButton: UIButton){
        var array = array2
        
        //The variables we will use to iterate
        var i = 1
        var j = 0
        
        Timer.scheduledTimer(withTimeInterval: time, repeats: true) { timer in
        guard i <= array.count else { timer.invalidate() ; return }
            
            //Stop condition for j
            if(j < array.count - i){
                //Select both rectangles to compare
                self.changeRectColor(rect: array[j])
                self.changeRectColor(rect: array[j+1])
                
                //Check if they need to be swapped
                if(array[j].height > array[j+1].height){
                    //Swap elements in the array (same result if we do it at the end)
                    array.swapAt(j, j+1)
                    
                    //Mark they have been selected to swap
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + self.time*0.3, execute: {
                        self.sortRectColor(rect: array[j])
                        self.sortRectColor(rect: array[j+1])
                        
                        //Swap
                        DispatchQueue.main.asyncAfter(wallDeadline: .now() + self.time*0.3, execute: {
                            let temp = array[j].xPos
                            array[j].xPos = array[j+1].xPos
                            array[j+1].xPos = temp
                            
                            self.swap(rect: &array[j])
                            self.swap(rect: &array[j+1])
                            
                            //Return to main color
                            DispatchQueue.main.asyncAfter(wallDeadline: .now() + self.time*0.3, execute: {
                                self.returnRectColor(rect: array[j])
                                self.returnRectColor(rect: array[j+1])
                                j += 1
                            })
                        })
                    })
                }
                //If there is no need to swap, we just return to the main color
                else{
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + self.time*0.3, execute: {
                        self.returnRectColor(rect: array[j])
                        self.returnRectColor(rect: array[j+1])
                        j += 1
                    })
                }
            }
            //When we reach the end of the array
            else{
                array[j].rectView.backgroundColor = #colorLiteral(red: 0.1246339352, green: 1, blue: 0.860940028, alpha: 1)
                j = 0
                i += 1
                
                if (i > array.count){
                    self.enableButtons(navBar: navBar, firstButton: firstButton, secondButton: secondButton, thirdButton: thirdButton)
                }
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
