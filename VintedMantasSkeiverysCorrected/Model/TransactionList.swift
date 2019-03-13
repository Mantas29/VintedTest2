//
//  TransactionList.swift
//  VintedMantasSkeiverysCorrected
//
//  Created by Mantas Skeiverys on 13/03/2019.
//  Copyright © 2019 Mantas Skeiverys. All rights reserved.
//

import Foundation

final class TransactionList{
    
    let transactions : [Transaction]
    
    init(transactions : [Transaction]){
        self.transactions = transactions
    }
    
    func setLowestSmallPackagePriceDiscount(){
        var lowestSmallPackagePrice : Double?
        let providerList = Provider.getAllProviders()
        
        for provider in providerList{
            if let price = provider.priceList["S"]{
                if let lowestPrice = lowestSmallPackagePrice{
                    if price < lowestPrice{
                        lowestSmallPackagePrice = price
                    }
                }else{
                    lowestSmallPackagePrice = price
                }
            }
        }
        for transaction in transactions{
            if transaction.isValid{
                if let price = transaction.price{
                    if let lowestPrice = lowestSmallPackagePrice{
                        if transaction.packageSize == "S"{
                            transaction.discount = price - lowestPrice
                            transaction.price = lowestPrice
                        }
                    }
                }
            }
        }
    }
    
    func setEveryThirdLargeLPPackageDiscount(){
        var lpCounter = 1
        
        for transaction in transactions{
            if transaction.isValid{
                if let providerShortName = transaction.provider?.shortName{
                    if let packageSize = transaction.packageSize{
                        if providerShortName == "LP" && packageSize == "L"{
                            if lpCounter == 3{
                                if let price = transaction.price{
                                    transaction.discount = price
                                    transaction.price = 0.0
                                    lpCounter = 1
                                }
                            }else{
                                lpCounter = lpCounter + 1
                            }
                        }
                    }
                }
            }
        }
    }
}
