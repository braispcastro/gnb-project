//
//  TransactionInfoPresenter.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation
import SwiftUI

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
        let exchanges = AdjacencyList<String>()
        let uniqueCurrency = Array(Set(rates.map { $0.from }))
        var exchangeGraph: [String: Vertex<String>] = [:]
        uniqueCurrency.forEach { item in
            exchangeGraph[item] = exchanges.createVertex(data: item)
        }
        
        rates.forEach { rate in
            exchanges.add(.directed, from: exchangeGraph[rate.from]!, to: exchangeGraph[rate.to]!, weight: 1)
        }
        
        if let edges = exchanges.breadthFirstSearch(from: exchangeGraph["EUR"]!, to: exchangeGraph["AUD"]!) {
            for edge in edges {
                print("\(edge.source) - \(edge.destination)")
            }
        }
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

struct Convertion: Hashable {
    let from: String
    let to: String
}
