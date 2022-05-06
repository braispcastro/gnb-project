//
//  TransactionListInteractor.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

protocol TransactionListInteractorProtocol {
    func getRates()
    func getTransactions()
}

protocol TransactionListInteractorCallbackProtocol {
    func rates(_ rates: [Bank.Rate])
    func transactions(_ transactions: [Bank.Transaction])
    func error(_ error: String?)
}

final class TransactionListInteractor {

    var presenter: TransactionListInteractorCallbackProtocol!
    private let bankService: BankService!

    init(bankService: BankService) {
        self.bankService = bankService
    }
}

extension TransactionListInteractor: TransactionListInteractorProtocol {
    
    func getRates() {
        bankService.rates(success: { rates in
            self.presenter.rates(rates)
        }, failure: { error in
            self.presenter.error(error?.localizedDescription)
        })
    }
    
    func getTransactions() {
        bankService.transactions(success: { transactions in
            self.presenter.transactions(transactions)
        }, failure: { error in
            self.presenter.error(error?.localizedDescription)
        })
    }
    
}
