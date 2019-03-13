//
//  TransactionListTest.swift
//  VintedMantasSkeiverysCorrectedTests
//
//  Created by Mantas Skeiverys on 13/03/2019.
//  Copyright © 2019 Mantas Skeiverys. All rights reserved.
//

import Foundation
import XCTest
@testable import VintedMantasSkeiverysCorrected

class TransactionListTest : XCTestCase{
    
    func testSetLowestSmallPackagePriceDiscount(){
        
        let provider = Provider(name: "Test", shortName: "ts", priceList: ["S" : 999])
        let transaction1 = Transaction(transactionText: "2019-01-01", date: Date(), packageSize: "S", provider: provider, price: 999)
        
        let transactionList = TransactionList(transactions: [transaction1])
        
        transactionList.setLowestSmallPackagePriceDiscount()
        
        XCTAssertTrue(transactionList.transactions[0].discount > 0)
        XCTAssertTrue(transactionList.transactions[0].price! < 999)
    }
    
    func testSetEveryThirdLargeLPPackageDiscount(){
        
        let provider = Provider(name: "Test", shortName: "LP", priceList: ["L" : 7])
        let transaction1 = Transaction(transactionText: "2019-01-01", date: Date(), packageSize: "L", provider: provider, price: 7)
        let transaction2 = Transaction(transactionText: "2019-01-01", date: Date(), packageSize: "L", provider: provider, price: 7)
        let transaction3 = Transaction(transactionText: "2019-01-01", date: Date(), packageSize: "L", provider: provider, price: 7)
        let transaction4 = Transaction(transactionText: "2019-01-01", date: Date(), packageSize: "L", provider: provider, price: 7)
        
        let transactionList = TransactionList(transactions: [transaction1, transaction2, transaction3, transaction4])
        
        transactionList.setEveryThirdLargeLPPackageDiscount()
        
        XCTAssertTrue(transactionList.transactions[0].discount == 0)
        XCTAssertTrue(transactionList.transactions[1].discount == 0)
        XCTAssertTrue(transactionList.transactions[2].discount == 7)
        XCTAssertTrue(transactionList.transactions[3].discount == 0)
    }
}
