//
//  Insertion.swift
//  Sorting Visualizer
//
//  Created by Samuel Miller on 12/18/19.
//  Copyright © 2019 Samuel Miller. All rights reserved.
//

import UIKit

class Insertion {
    var rectGenerator = GenerateRectangles()
    var time = 1.0
    
    //Key color
    func keyColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    }
    
    //Comparisson color
    func compareColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }
    
    //Swap color
    func toSwapColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
    
    //Original color
    func returnColor(rect: Rectangle){
        rect.rectView.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
    
    //Mark and move down the key rectangle
    func keySelected(key: inout Rectangle, view: UIView){
        self.keyColor(rect: key)
        key.yPos = 160
        key.rectView.frame = key.toCGRect()
    }
    
    func insertionSort(array2: [Rectangle], view: UIView, navBar: UINavigationItem, firstButton: UIButton, secondButton: UIButton, thirdButton: UIButton){
        var array = array2
        var i = 1
        var j = i - 1
        var key = array[i]
        
        Timer.scheduledTimer(withTimeInterval: time, repeats: true) { timer in
        guard i < array.count else { timer.invalidate() ; return }
            //Mark the current key
            self.keySelected(key: &key, view: view)
            
            //Mark the rectangle we are comparing the key with
            if(j >= 0){
                self.compareColor(rect: array[j])  
            }
            
            //Check if a swap is needed
            if(j >= 0 && array[j].height > key.height){
                DispatchQueue.main.asyncAfter(deadline: .now() + self.time*0.3, execute: {
                    //Mark the rectangle as selected
                    self.toSwapColor(rect: array[j])
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.time*0.3, execute: {
                        //Swap X positions
                        let temp = key.xPos
                        key.xPos = array[j].xPos
                        array[j].xPos = temp
                        
                        //Move the rectangles
                        key.rectView.frame = key.toCGRect()
                        array[j].rectView.frame = array[j].toCGRect()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.time*0.3, execute: {
                            //Return the compared rectangle to its original color
                            self.returnColor(rect: array[j])
                            
                            //Change values in array
                            array[j+1] = array[j]
                            j -= 1
                        })
                    })
                })
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + self.time*0.3, execute: {
                    //Return the comapred rectangle to its original color
                    if (j >= 0){
                        self.returnColor(rect: array[j])
                    }
                    
                    //Return the key to its original position
                    key.yPos = 0
                    key.rectView.frame = key.toCGRect()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.time*0.3, execute: {
                        //Return the key color to its original one
                        self.returnColor(rect: key)
                        
                        //Arrange values in array
                        array[j+1] = key
                        i += 1
                        j = i - 1
                        if (i < array.count){
                            key = array[i]
                        }
                            
                        //When this is reached, it means the array has been sorted
                        else{
                            for i in 0 ..< array.count{
                                array[i].rectView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                            }
                            self.enableButtons(navBar: navBar, firstButton: firstButton, secondButton: secondButton, thirdButton: thirdButton)
                        }
                    })
                    
                })
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
