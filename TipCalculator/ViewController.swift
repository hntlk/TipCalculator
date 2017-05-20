//
//  ViewController.swift
//  TipCalculator
//
//  Created by Cntt22 on 5/20/17.
//  Copyright © 2017 Cntt22. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txt_Bill: UITextField!
    
    @IBOutlet weak var lbl_tip: UILabel!
    @IBOutlet weak var lbl_total: UILabel!
    @IBOutlet weak var option: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    var roundingSetting = 0

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let percentSetting = defaults.integer(forKey: "tip_percent")
        
        option.selectedSegmentIndex = percentSetting
        self.option.selectedSegmentIndex = defaults.integer(forKey: "rounding")
        
        self.onEditingChanged(self)
    }
    
    @IBAction func onEditingChanged(_ sender: AnyObject) {
        var billAmount = NSString(string: txt_Bill.text!).doubleValue
        let tipPercentages = [0.05, 0.10, 0.15]
        let tipPercent = tipPercentages[option.selectedSegmentIndex]
        
        if billAmount > 999 {
            billAmount = billAmount / 100
            txt_Bill.text = "\(billAmount)"
        }
        
        var tip = billAmount * tipPercent
        var total = billAmount + tip
        
        if (self.roundingSetting == 1) {
            tip = round(tip)
            total = billAmount + tip
        } else if (self.roundingSetting == 2) {
            total = round(total)
            tip = total - billAmount
        }
        
        lbl_tip.text = String(format: "$%.2f", tip)
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }


}

