//
//  TransactionTableExtension.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 30/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension TransactionsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == historyTableView{
            return listOfOrders.count
        }else if tableView == checkItemsTableView{
            return listOfItems.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == historyTableView{
            let order = listOfOrders[indexPath.row]
            let cell = historyTableView.dequeueReusableCell(withIdentifier: historyCellId, for: indexPath) as! OrderHistoryCell
            cell.updateDataInCell(order: order)
            cell.backgroundColor = UIColor(named: "background")
            return cell
        }else if tableView == checkItemsTableView {
            let item = listOfItems[indexPath.row]
            let cell = checkItemsTableView.dequeueReusableCell(withIdentifier: checkItemsCellId, for: indexPath) as! CheckItemCell
            cell.updateDataInCell(item: item)
            return cell
        }else{
            let cell = historyTableView.dequeueReusableCell(withIdentifier: historyCellId, for: indexPath) as! OrderHistoryCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if tableView == historyTableView{
            return 70
        }else if tableView == checkItemsTableView{
            return 50
         }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == historyTableView{
            return historyTableView.deselectRow(at: indexPath, animated: true)
        }else if tableView == checkItemsTableView{
            return checkItemsTableView.deselectRow(at: indexPath, animated: true)
        }else{
            return checkItemsTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == historyTableView{
            let closeAction = UIContextualAction(style: .destructive, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
        
                
                success(true)
            })
            closeAction.title = "Return"
            closeAction.backgroundColor = UIColor(named:"4")
            return UISwipeActionsConfiguration(actions: [closeAction])
        
            }else if tableView == checkItemsTableView{
            return UISwipeActionsConfiguration.init()
        }else{
            return UISwipeActionsConfiguration.init()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         if tableView == historyTableView{
            let closeAction = UIContextualAction(style: .destructive, title:  "More", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
//            self.itemInCart.append(self.itemInCart[indexPath.row])
//            self.cartTableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//            self.cartTableView.reloadData()
//            self.calculateTotal()
            
            success(true)
        })
        closeAction.title = "More"
        closeAction.backgroundColor = UIColor(named:"1")
            return UISwipeActionsConfiguration(actions: [closeAction])
    }else if tableView == checkItemsTableView{
        return UISwipeActionsConfiguration.init()
    
    }else{
        return UISwipeActionsConfiguration.init()
        }
    }
}
