//
//  TransactionInfoPresenter.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

protocol TransactionInfoViewControllerProtocol {

}

protocol TransactionInfoPresenterProtocol {
    func prepareView()
}

final class TransactionInfoPresenter {
    
    private let viewController: TransactionInfoViewControllerProtocol!
    private let rates: [Bank.Rate]!
    private let transactions: [Bank.Transaction]!

    init(viewController: TransactionInfoViewControllerProtocol,
         rates: [Bank.Rate],
         transactions: [Bank.Transaction]) {
        self.viewController = viewController
        self.rates = rates
        self.transactions = transactions
    }
    
}

extension TransactionInfoPresenter: TransactionInfoPresenterProtocol {
    
    func prepareView() {
        
    }

}
