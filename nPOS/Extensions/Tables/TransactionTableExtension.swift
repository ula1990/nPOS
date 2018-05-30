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
        }else{
            let cell = historyTableView.dequeueReusableCell(withIdentifier: historyCellId, for: indexPath) as! OrderHistoryCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return historyTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .destructive, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
    
            
            success(true)
        })
        closeAction.title = "Return"
        closeAction.backgroundColor = UIColor(named:"4")
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
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
    }
}
