//
//  ViewController.swift
//  Sorting Visualizer
//
//  Created by Samuel Miller on 12/14/19.
//  Copyright © 2019 Samuel Miller. All rights reserved.
//

import UIKit

class SortingController: UIViewController {
    let bubbleSort = BubbleSort()
    let selectionSort = Selection()
    let insertionSort = Insertion()
    var selectedSort = "bubble"
    var arrayToSort = [Rectangle]()
    var genRect = GenerateRectangles()
    
    @IBOutlet weak var rectangleView: UIView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var bubbleButton: UIButton!
    @IBOutlet weak var insertionButton: UIButton!
    @IBOutlet weak var selectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarItems()
        bubbleButton.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        arrayToSort = genRect.allTheRectangles(quantity: 18, view: rectangleView)
    }
    
    @IBAction func sortingChanged(_ sender: UIButton) {
//        sender.isSelected = true
        sender.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        if sender == bubbleButton {
            insertionButton.backgroundColor = #colorLiteral(red: 0.4705882353, green: 0.5882352941, blue: 1, alpha: 1)
            selectionButton.backgroundColor = #colorLiteral(red: 0.4705882353, green: 0.5882352941, blue: 1, alpha: 1)
            selectedSort = "bubble"
        }
        else if sender == insertionButton {
            bubbleButton.backgroundColor = #colorLiteral(red: 0.4705882353, green: 0.5882352941, blue: 1, alpha: 1)
            selectionButton.backgroundColor = #colorLiteral(red: 0.4705882353, green: 0.5882352941, blue: 1, alpha: 1)
            selectedSort = "insertion"
        }
        else if sender == selectionButton {
            bubbleButton.backgroundColor = #colorLiteral(red: 0.4705882353, green: 0.5882352941, blue: 1, alpha: 1)
            insertionButton.backgroundColor = #colorLiteral(red: 0.4705882353, green: 0.5882352941, blue: 1, alpha: 1)
            selectedSort = "selection"
        }
    }
    
    
    private func setupNavBarItems(){
        //Title
        let titleString = "Sorting Visualizer"
        let attributeFont = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attString = NSAttributedString(string: titleString, attributes: attributeFont)
        let titleView = UILabel()
        titleView.attributedText = attString
        navigationBar.titleView = titleView
        
        //Generate Array Button
        let generateButtonString = "Generate New Array"
        let generateArrayButton = UIBarButtonItem()
        generateArrayButton.action = #selector(generateArrayTapped)
        generateArrayButton.title = generateButtonString
        generateArrayButton.setTitleTextAttributes(attributeFont, for: .normal)
        navigationBar.leftBarButtonItem = generateArrayButton

        //Sort Button
        let sortButtonString = "Sort!"
        let sortButton = UIBarButtonItem()
        sortButton.action = #selector(sortTapped)
        sortButton.title = sortButtonString
        sortButton.setTitleTextAttributes(attributeFont, for: .normal)
        navigationBar.rightBarButtonItem = sortButton
    }
    
    @objc func sortTapped(){
        disableAllButtons()
        if selectedSort == "bubble" {
            bubbleSort.bubbleSort(array2: arrayToSort, view: rectangleView, navBar: navigationBar, firstButton: bubbleButton, secondButton: insertionButton, thirdButton: selectionButton)
        }
        else if selectedSort == "insertion" {
            insertionSort.insertionSort(array2: arrayToSort, view: rectangleView, navBar: navigationBar, firstButton: bubbleButton, secondButton: insertionButton, thirdButton: selectionButton)
        }
        else{
            selectionSort.selectionSort(array2: arrayToSort, view: rectangleView, navBar: navigationBar, firstButton: bubbleButton, secondButton: insertionButton, thirdButton: selectionButton)
        }
        
        
    }
    
    @objc func generateArrayTapped(){
        //Remove all rectangle views and values from the array
        genRect.removeAllRectangles(rectArray: &arrayToSort, view: rectangleView)
        
        //Generate a new array
        arrayToSort = genRect.allTheRectangles(quantity: 18, view: rectangleView)
        
    }
    
    func disableAllButtons(){
        navigationBar.leftBarButtonItem?.isEnabled = false
        navigationBar.rightBarButtonItem?.isEnabled = false
        bubbleButton.isEnabled = false
        selectionButton.isEnabled = false
        insertionButton.isEnabled = false
        
    }
    
}

