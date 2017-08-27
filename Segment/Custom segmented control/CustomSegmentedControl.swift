//
//  CustomSegmentedControl.swift
//  SegmentedControl
//
//  Created by Bharat Lal on 26/08/17.
//  Copyright © 2017 Bharat Lal. All rights reserved.
//

import UIKit
 @IBDesignable class CustomSegmentedControl: UIControl{
    
    private var labels = [UILabel]()

    var thumbView  = UIView()
    var items: [String] = ["Item 1", "Item 2", "Item 3"] {
        didSet {
            setupLables()
        }
    }
    @IBInspectable var thumbColor: UIColor = UIColor.white {
        didSet{
            setColors()
        }
    }
    @IBInspectable var selectedSegmentTextColor : UIColor = UIColor.black {
        didSet {
            setColors()
        }
    }
    
    @IBInspectable var unselectedSegmentTextColor : UIColor = UIColor.white {
        didSet {
            setColors()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var font : UIFont! = UIFont.systemFont(ofSize: 12) {
        didSet {
            setFont()
        }
    }
    var selectedIndex: Int = 0{
        didSet{
            displaySelectedIndex()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setupView()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        var calculatedIndex : Int?
        var index = 0
        for label in labels{
            if label.frame.contains(location){
                calculatedIndex = index
                break
            }
            index += 1
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectFrame = self.bounds
        let thumWidth = selectFrame.width / CGFloat(items.count)
        selectFrame.size.width = thumWidth
        thumbView.frame = selectFrame
        thumbView.backgroundColor = thumbColor
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        let labelheight = bounds.size.height
        for index in 0...labels.count - 1{
            let label = labels[index]
            let xPos = CGFloat(index) * thumWidth
            label.frame = CGRect(x: xPos, y: 0, width: thumWidth, height: labelheight)
        }
        
        displaySelectedIndex()
    }
    
    //MARK: Private
   private func displaySelectedIndex(){
        for label in labels{
            label.textColor = unselectedSegmentTextColor
        }
        
        let label = labels[selectedIndex]
        label.textColor = selectedSegmentTextColor
        
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: {
            self.thumbView.frame = label.frame
            
        }, completion: nil)
        
    }
   private func setupLables(){
        for label in labels{
            label.removeFromSuperview()
        }
        labels.removeAll(keepingCapacity: true)
        
        for index in 1...items.count{
            let label = UILabel(frame: CGRect.zero)
            label.text = items[index - 1]
            label.backgroundColor = UIColor.clear
            label.textAlignment = .center
            label.textColor = UIColor.init(white: 0.5, alpha: 1.0)
            self.addSubview(label)
            labels.append(label)
        }
    }
    private func setupView(){
        layer.cornerRadius = frame.size.height / 2
        layer.borderColor = UIColor.init(white: 1.0, alpha: 1.0).cgColor
        layer.borderWidth = 2.0
        
        backgroundColor = UIColor.clear
        insertSubview(thumbView, at: 0)
        setupLables()
    }
    private func setColors(){
        for item in labels {
            item.textColor = unselectedSegmentTextColor
        }
        
        if labels.count > 0 {
            labels[0].textColor = selectedSegmentTextColor
        }
        
        thumbView.backgroundColor = thumbColor
    }
    
   private func setFont(){
        for item in labels {
            item.font = font
        }
    }
}
