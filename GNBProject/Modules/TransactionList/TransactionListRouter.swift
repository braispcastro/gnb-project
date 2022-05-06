//
//  TransactionListRouter.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

protocol TransactionListRouterProtocol {

}

class TransactionListRouter: TransactionListRouterProtocol {
    
    private let viewController: TransactionListViewController!
    
    init(viewController: TransactionListViewController) {
        self.viewController = viewController
    }

}
