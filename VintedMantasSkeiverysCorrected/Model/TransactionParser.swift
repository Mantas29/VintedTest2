//
//  TransactionParser.swift
//  VintedMantasSkeiverysCorrected
//
//  Created by Mantas Skeiverys on 13/03/2019.
//  Copyright © 2019 Mantas Skeiverys. All rights reserved.
//

import Foundation

final class TransactionParser {
    
    func getRawTransactionList(transactionListText : String) -> [RawTransaction]{
        var rawTransactionList : [RawTransaction] = []
        let lines = transactionListText.components(separatedBy: CharacterSet.newlines)
        for line in lines{
            let rawTransaction = RawTransaction(transactionText: line)
            rawTransactionList.append(rawTransaction)
        }
        return rawTransactionList
    }
    
    func createTransactionList(rawTransactions : [RawTransaction]) -> TransactionList{
        var transactionArray : [Transaction] = []
        
        for rawTransaction in rawTransactions{
            if rawTransaction.transactionComponents.count == 3{
                let transactionDate = rawTransaction.transactionComponents[0]
                let transactionPackageSize = rawTransaction.transactionComponents[1]
                let transactionProviderShortName = rawTransaction.transactionComponents[2]
                let transaction = createTransactionFromComponents(transactionText: rawTransaction.transactionText, dateText: transactionDate, packageSize: transactionPackageSize, providerShortName: transactionProviderShortName)
                transactionArray.append(transaction)
            }else{
                transactionArray.append(Transaction(transactiontext: rawTransaction.transactionText))
            }
        }
        return TransactionList(transactions: transactionArray)
    }
    
    private func createTransactionFromComponents(transactionText : String, dateText : String, packageSize : String, providerShortName : String) -> Transaction{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        
        let transactionDate : Date
        
        if let date = dateFormatter.date(from: dateText){
            transactionDate = date
        }else{
            return Transaction(transactiontext: transactionText)
        }
    
        let providerList = Provider.getAllProviders()
        
        for provider in providerList{
            if provider.shortName == providerShortName{
                if let price = provider.priceList[packageSize]{
                    return Transaction(transactionText: transactionText, date: transactionDate, packageSize: packageSize, provider: provider, price: price)
                }
            }
        }
        return Transaction(transactiontext: transactionText)
    }
    
    
    
    
}
