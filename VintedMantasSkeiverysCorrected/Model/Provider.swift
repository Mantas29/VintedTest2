//
//  Provider.swift
//  VintedMantasSkeiverysCorrected
//
//  Created by Mantas Skeiverys on 12/03/2019.
//  Copyright © 2019 Mantas Skeiverys. All rights reserved.
//

import Foundation

final class Provider{
    
    let name : String
    let shortName : String
    let priceList : [String : Double]
    
    init(name : String, shortName : String, priceList : [String : Double]){
        self.name = name
        self.shortName = shortName
        self.priceList = priceList
    }
    
    static func getAllProviders() -> [Provider]{
        let LaPoste = Provider(name: "La Poste", shortName: "LP", priceList: ["S" : 1.50, "M" : 4.90, "L" : 6.90])
        let MondialRelay = Provider(name: "Mondial Relay", shortName: "MR", priceList: ["S" : 2, "M" : 3, "L" : 4])
                
        return [LaPoste, MondialRelay]
    }
}
