//
//  ViewController.swift
//  PizzaApp
//
//  Created by mac on 5/8/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import UIKit

class TopPizzasViewController: UIViewController {
    
    @IBOutlet weak var pizzaTableView: UITableView!
    
    var pizzas: [(Pizza, Int)] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        fetchPizzas(count: Preferences.pizzaCount)        
    }
    
    func fetchPizzas(count: Int){
        PizzaService.getPizzas(limit: count){ [unowned self] pizzas in
            self.pizzas = pizzas
            DispatchQueue.main.async {
                self.pizzaTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? SettingsViewController else {
            return
        }
        
        vc.delegate = self
    }
}

extension TopPizzasViewController: SettingsDelegate {
    
    func updatedPizzaCount(to count: Int) {
        fetchPizzas(count: count)
    }
}

extension TopPizzasViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PizzaCell", for: indexPath)
        
        let pizza = pizzas[indexPath.row].0
        cell.textLabel?.text = pizza.toppings.joined(separator: ", ")
        
        let number = "\(pizzas[indexPath.row].1)"
        cell.detailTextLabel?.text = number
        
        return cell
    }
}
