//
//  SettingsViewController.swift
//  PizzaApp
//
//  Created by mac on 5/9/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class {
    
    func updatedPizzaCount(to count: Int)
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var numberLabel: UILabel!
    
    weak var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel.text = String(Preferences.pizzaCount)
        slider.value = Float(Preferences.pizzaCount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let value = Int(slider.value)
        
        numberLabel.text = String(value)
    }

    @IBAction func savedChanges(_ sender: Any) {
        let value = Int(slider.value)

        // save the user preferences - update the pizza limit
        Preferences.setPizzaCount(to: value)
        
        // call the delegate function
        delegate?.updatedPizzaCount(to: Int(slider.value))

        // go back to the previous screen
        navigationController?.popViewController(animated: true)
    }
}
