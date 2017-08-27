//
//  ViewController.swift
//  Segment
//
//  Created by Bharat Lal on 27/08/17.
//  Copyright © 2017 Bharat Lal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectedItem: UILabel!
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //segmentedControl.items = ["My item", "Your item", "Our item"]
        
        segmentedControl.addTarget(self, action: #selector(ViewController.segmentedValueChanged(_:)), for: .valueChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func segmentedValueChanged(_ sender: CustomSegmentedControl){
        selectedItem.text = "\(sender.selectedIndex) selected"
    }

}

