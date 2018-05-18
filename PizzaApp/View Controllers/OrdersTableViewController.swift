//
//  OrdersTableViewController.swift
//  PizzaApp
//
//  Created by mac on 5/11/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    let cellIdentifier = "OrderCell"
    var orders: [Order] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getAllOrders()
        
        NotificationCenter
            .default
            .addObserver(
            forName: .orderCreated,
            object: nil,
            queue: nil){ [unowned self] _ in
            self.getAllOrders()
        }
        
//    NotificationCenter
//        .default
//        .addObserver(
//            self,
//            selector: #selector(getAllOrders),
//            name: .orderCreated,
//            object: nil)
    }
    
    
    func getAllOrders(){
        PizzaService.getOrders(){ [unowned self] orders in
            self.orders = orders
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        tableView.deselectRow(at: indexPath, animated: true)
        
        let favorite = !orders[indexPath.row].favorite
        orders[indexPath.row].favorite = favorite
        
        let cell = tableView.cellForRow(at: indexPath)
        if favorite {
            cell?.accessoryType = .checkmark
        }else {
            cell?.accessoryType = .none
        }
        
        PizzaService.updateOrder(
            orders[indexPath.row])
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let order = orders[indexPath.row]
        cell.textLabel?.text = order.toppingString
        
        if order.favorite {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }

        return cell
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        PizzaService.deleteOrder(dateOfRecord: orders[indexPath.row].date)
        orders.remove(at: indexPath.row)
        
        // update table view
        tableView.deleteRows(at: [indexPath], with: .automatic)
       
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
