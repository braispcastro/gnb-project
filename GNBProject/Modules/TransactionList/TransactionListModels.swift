//
//  TransactionListModels.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

enum TransactionList {
    
    struct ViewModel: Equatable {
        let title: String
    }
    
    struct TransactionViewModel: Hashable {
        let sku: String
    }

}
