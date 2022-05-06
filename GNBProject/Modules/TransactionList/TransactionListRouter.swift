//
//  TransactionListRouter.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

protocol TransactionListRouterProtocol {
    func navigateToInformation(transactions: [Bank.Transaction], rates: [Bank.Rate])
}

class TransactionListRouter: TransactionListRouterProtocol {
    
    private let viewController: TransactionListViewController!
    
    init(viewController: TransactionListViewController) {
        self.viewController = viewController
    }
    
    func navigateToInformation(transactions: [Bank.Transaction], rates: [Bank.Rate]) {
        let vc = TransactionInfoBuilder.build(transactions: transactions, rates: rates)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

}
