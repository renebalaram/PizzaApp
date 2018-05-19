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
    
    @IBOutlet weak var sortingType: UISegmentedControl!
    var pizzas: [(Pizza, Int)] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sorting: Entity.Sorting = Preferences.sortingType
        switch sorting {
        case .byPopularity:
            sortingType.selectedSegmentIndex = 0
        case .byNameAsc:
            sortingType.selectedSegmentIndex = 1
        case .byNameDesc:
            sortingType.selectedSegmentIndex = 2
        }
        fetchPizzas(count: Preferences.pizzaCount)
        
    }
    
    @IBAction func sortingTipeChanged(_ sender: Any) {
        switch sortingType.selectedSegmentIndex {
        case 0:
            Preferences.setPizzaSorting(as: Entity.Sorting.byPopularity)
        case 1:
            Preferences.setPizzaSorting(as: Entity.Sorting.byNameAsc)
        case 2:
            Preferences.setPizzaSorting(as: Entity.Sorting.byNameDesc)
        default:
            Preferences.setPizzaSorting(as: Entity.Sorting.byPopularity)
        }
        fetchPizzas(count: Preferences.pizzaCount)
    }
    
    func fetchPizzas(count: Int){
        PizzaService.getPizzas(limit: count,sorting: Preferences.sortingType){ [unowned self] pizzas in
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
