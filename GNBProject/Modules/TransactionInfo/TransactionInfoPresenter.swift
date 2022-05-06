//
//  TransactionInfoPresenter.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

protocol TransactionInfoViewControllerProtocol {
    func show(viewModel: TransactionInfo.ViewModel)
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
    
    // MARK: - Private Methods
    
    private func convertTransactionsToEuros(transactions: [Bank.Transaction]) -> [TransactionInfo.Transaction] {
        getAllRates()
        var convertedTransactions: [TransactionInfo.Transaction] = []
        transactions.forEach { transaction in
            convertedTransactions.append(TransactionInfo.Transaction(sku: transaction.sku, euros: "\(transaction.amount) \(transaction.currency)"))
        }
        
        return convertedTransactions
    }
    
    private func getAllRates() {
        //TODO: Dijkstra
    }
    
}

extension TransactionInfoPresenter: TransactionInfoPresenterProtocol {
    
    func prepareView() {
        let convertedTransactions = convertTransactionsToEuros(transactions: transactions)
        let viewModel = TransactionInfo.ViewModel(title: transactions.first!.sku,
                                                  transactions: convertedTransactions,
                                                  total: "Total: 100 EUR")
        
        viewController.show(viewModel: viewModel)
    }

}
