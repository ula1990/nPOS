//
//  TransferTableInfo.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 25/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension TableVC: transferSelectedColorDelegate{
    func colorReceived(selectedColor: UIColor?) {
        self.selectColorButton.backgroundColor = selectedColor
    }
}
