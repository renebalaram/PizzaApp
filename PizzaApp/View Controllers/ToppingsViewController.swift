//
//  ToppingsViewController.swift
//  PizzaApp
//
//  Created by mac on 5/10/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import UIKit

class ToppingsViewController: UIViewController {
    
    @IBOutlet weak var toppingsTableView: UITableView!
    @IBOutlet weak var toppingsPickerView: UIPickerView!
    
    @IBOutlet weak var customToppingTextField: UITextField!
    
    let cellIdentifier = "ToppingCell"
    
    var toppings = ["Pepperoni", "Ham", "Pineapple", "Olives", "Peppers", "Bacon", "Chicken", "Spinach"].sorted()
    
    var selectedToppings: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PizzaService.getToppings(completion: { toppingsFetched in
            self.toppings = toppingsFetched.sorted()
            DispatchQueue.main.async {
                self.toppingsPickerView.reloadAllComponents()
            }
            
        })
        
    }
    
    @IBAction func toppingAdded(_ sender: Any) {
        guard !toppings.isEmpty else { return }
        
        let row = toppingsPickerView.selectedRow(inComponent: 0)
        
        let selectedTopping = toppings[row]
        
        print("Selected \(selectedTopping)")
        toppings.remove(at: row)
        toppings = toppings.sorted()
        toppingsPickerView.reloadAllComponents()
     
        addTopping(selectedTopping)
    }
    
    func addTopping(_ topping: String){
        
        // add to the array of selected toppings
        selectedToppings.append(topping)
        
        // get the index path of the new row
        let ip = IndexPath(row: selectedToppings.count-1, section: 0)
        
        // update table view
        toppingsTableView.insertRows(at: [ip], with: .automatic)
    }
    
    @IBAction func pizzaOrdered(_ sender: Any) {
        PizzaService.saveOrder(toppings: selectedToppings)
        
        toppings = (toppings + selectedToppings).sorted()
        selectedToppings.removeAll()
        
        toppingsPickerView.reloadAllComponents()
        toppingsTableView.reloadData()
    }
    
    @IBAction func saveCustomTopping(_ sender: UIButton) {
        if let newTopping = customToppingTextField.text {
            if !(newTopping == "") && !selectedToppings.contains(newTopping) && !toppings.contains(newTopping) {
                toppings.append(newTopping)
                customToppingTextField.text = ""
                PizzaService.saveToping(topping: newTopping)
                toppingsPickerView.reloadAllComponents()
            }
        }
    }
    
    
    
}

extension ToppingsViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return toppings.count
    }
}

extension ToppingsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return toppings[row]
    }
}

extension ToppingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedToppings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = selectedToppings[indexPath.row]
        return cell
    }
}

extension ToppingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }

        let removedTopping = selectedToppings.remove(at: indexPath.row)
        
        // update table view
        toppingsTableView.deleteRows(at: [indexPath], with: .automatic)
        
        toppings.append(removedTopping)
        toppings = toppings.sorted()
        
        toppingsPickerView.reloadAllComponents()
    }
}
