//
//  ViewController.swift
//  VintedMantasSkeiverysCorrected
//
//  Created by Mantas Skeiverys on 12/03/2019.
//  Copyright © 2019 Mantas Skeiverys. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let transactionParser = TransactionParser()
        
        if let transactionFileText = readInputFile(){
            let rawTransactionList = transactionParser.getRawTransactionList(transactionListText: transactionFileText)
            let transactionList = transactionParser.createTransactionList(rawTransactions: rawTransactionList)
            transactionList.setLowestSmallPackagePriceDiscount()
            transactionList.setEveryThirdLargeLPPackageDiscount()
            writeOutput(transactionList: transactionList)
        }
    }
    
    private func writeOutput(transactionList : TransactionList){
        var output = ""
        for transaction in transactionList.transactions{
            output.append(transaction.transactionText)
            if transaction.isValid{
                output.append(" \(String(format: "%.2f", transaction.price!))")
                if transaction.discount > 0.0{
                    output.append(" \(String(format: "%.2f", transaction.discount))")
                }else{
                    output.append(" -")
                }
            }else{
                output.append(" Ignored")
            }
            output.append("\n")
        }
        print(output)
        overwriteOutputFile(text: output)
    }
    
    private func readInputFile() -> String?{
        if let inputFilePath = Bundle.main.path(forResource: "input", ofType: "txt"){
            print("Input file location: \(inputFilePath)\n")
            let url = URL(fileURLWithPath: inputFilePath)
            do{
                let fileText = try String(contentsOf: url, encoding: .utf8)
                return fileText
            }
            catch{
                print("Could not read the input file!")
            }
        }else{
            print("Input file does not exist!")
        }
        return nil
    }
    
    private func overwriteOutputFile(text : String){
        if let outputFilePath = Bundle.main.path(forResource: "output", ofType: "txt"){
            print("Output file location: \(outputFilePath)")
            let fileURL = URL(fileURLWithPath: outputFilePath)
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                print("Writing to file failed!")
            }
        }else{
            print("Output file does not exist!")
        }
    }


}

