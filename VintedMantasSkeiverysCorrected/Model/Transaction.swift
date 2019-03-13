//
//  Transaction.swift
//  VintedMantasSkeiverysCorrected
//
//  Created by Mantas Skeiverys on 12/03/2019.
//  Copyright © 2019 Mantas Skeiverys. All rights reserved.
//

import Foundation

final class Transaction{
    
    let isValid : Bool
    let transactionText : String
    var discount : Double = 0.0
    var date : Date?
    var packageSize : String?
    var provider : Provider?
    var price : Double?
    
    init(transactiontext : String){
        self.transactionText = transactiontext
        isValid = false
    }
        
    init(transactionText : String, date : Date, packageSize : String, provider : Provider, price : Double){
        self.transactionText = transactionText
        self.date = date
        self.packageSize = packageSize
        self.provider = provider
        self.price = price
        isValid = true
    }
}
