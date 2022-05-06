//
//  TransactionInfoModels.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

enum TransactionInfo {

    struct ViewModel {
        let title: String
        let transactions: [Transaction]
        let total: String
    }
    
    struct Transaction {
        let sku: String
        let euros: String
    }
    
    struct Rate {
        let from: String
        let to: String
        let rate: Decimal
    }
    
}
