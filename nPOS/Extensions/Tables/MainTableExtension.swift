//
//  TableExtension.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 22/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemInCart.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let item = itemInCart[indexPath.row]
            let cell = cartTableView.dequeueReusableCell(withIdentifier: cartCellId, for: indexPath) as! CartCell
            cell.backgroundColor = UIColor(named: "background")
            cell.updateDataInCell(item: item)
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

             return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            return cartTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .destructive, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in

            self.itemInCart.remove(at: indexPath.row)
            self.cartTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            self.cartTableView.reloadData()
            self.calculateTotal()
            
            success(true)
        })
        closeAction.title = "Delete"
        closeAction.backgroundColor = UIColor(named:"4")
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    
}
