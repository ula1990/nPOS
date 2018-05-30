//
//  NotificationExtension.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 27/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let saveColor = Notification.Name(rawValue: "saveColor")
    static let selectedTable = Notification.Name(rawValue: "selectedTable")
    static let selectedGiftCard = Notification.Name(rawValue: "selectedGiftCard")
    static let totalAmount = Notification.Name(rawValue: "totalAmount")
    static let addItem = Notification.Name(rawValue: "addItem")
    static let addDiscountToCart = Notification.Name(rawValue: "addDiscountToCart")
}

