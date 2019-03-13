//
//  TransactionParserTests.swift
//  VintedMantasSkeiverysCorrectedTests
//
//  Created by Mantas Skeiverys on 13/03/2019.
//  Copyright © 2019 Mantas Skeiverys. All rights reserved.
//

import Foundation
import XCTest
@testable import VintedMantasSkeiverysCorrected

class TransactionParserTests: XCTestCase{
    
    func testGetRawTransactionList(){
        
        let transactionListText = "2019-01-01 test1 test2 test3\n2019-02-02 test4 test5\n2019-03-03 test6 test7"
        
        let transactionParser = TransactionParser()
        
        let rawTransactions = transactionParser.getRawTransactionList(transactionListText: transactionListText)
        
        XCTAssertTrue(rawTransactions.count == 3)
        XCTAssertEqual(rawTransactions[0].transactionComponents.count, 4)
        XCTAssertEqual(rawTransactions[1].transactionComponents.count, 3)
    }
    
    func testCreateTransactionList(){
        
        let transactionParser = TransactionParser()
        
        let rawTransaction1 = RawTransaction(transactionText: "2019-01-01 L LP")
        let rawTransaction2 = RawTransaction(transactionText: "2019-01-00 L LP")
        let rawTransaction3 = RawTransaction(transactionText: "2019-01-01 XL LP")
        let rawTransaction4 = RawTransaction(transactionText: "2019-01-01 L QQ")
        let rawTransaction5 = RawTransaction(transactionText: "2019-01-01 L LP random")
        let rawTransaction6 = RawTransaction(transactionText: "2019-01-01 L")
        
        let rawTransactionArray = [rawTransaction1, rawTransaction2, rawTransaction3, rawTransaction4, rawTransaction5, rawTransaction6]
        
        let transactionList = transactionParser.createTransactionList(rawTransactions: rawTransactionArray)
        
        XCTAssertEqual(transactionList.transactions.count, 6)
        XCTAssertTrue(transactionList.transactions[0].isValid)
        XCTAssertFalse(transactionList.transactions[1].isValid)
        XCTAssertFalse(transactionList.transactions[2].isValid)
        XCTAssertFalse(transactionList.transactions[3].isValid)
        XCTAssertFalse(transactionList.transactions[4].isValid)
        XCTAssertFalse(transactionList.transactions[5].isValid)
    }
}
