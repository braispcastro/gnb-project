//
//  BankModels.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

struct Bank {
    
    struct Rate: Decodable {
        let from: String
        let to: String
        let rate: String
    }
    
    struct Transaction: Decodable {
        let sku: String
        let amount: String
        let currency: String
    }
    
}
