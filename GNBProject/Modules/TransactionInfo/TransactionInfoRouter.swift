//
//  TransactionInfoRouter.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

protocol TransactionInfoRouterProtocol {

}

class TransactionInfoRouter: TransactionInfoRouterProtocol {
    
    private let viewController: TransactionInfoViewController!
    
    init(viewController: TransactionInfoViewController) {
        self.viewController = viewController
    }

}
