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
    
    private var exchanges: AdjacencyList<String>!
    private var exchangeGraph: [String: Vertex<String>]!
    private var total: Int = 0

    init(viewController: TransactionInfoViewControllerProtocol,
         rates: [Bank.Rate],
         transactions: [Bank.Transaction]) {
        self.viewController = viewController
        self.rates = rates
        self.transactions = transactions
    }
    
    // MARK: - Private Methods
    
    private func convertTransactionsToEuros(transactions: [Bank.Transaction]) -> [TransactionInfo.Transaction] {
        var convertedTransactions: [TransactionInfo.Transaction] = []
        transactions.forEach { transaction in
            if let rate = getConversionRate(from: transaction.currency, to: "EUR"), let price = Double(transaction.amount) {
                let roundedPrice = (price * rate).roundHalfToEven()
                convertedTransactions.append(TransactionInfo.Transaction(sku: "\(transaction.sku) - \(transaction.amount) \(transaction.currency)",
                                                                         euros: "Converted value: \(roundedPrice) EUR"))
                total += roundedPrice
            }
        }
        
        return convertedTransactions
    }
    
    private func getAllRates() {
        exchanges = AdjacencyList<String>()
        exchangeGraph = [:]
        
        let uniqueCurrency = Array(Set(rates.map { $0.from }))
        uniqueCurrency.forEach { item in
            exchangeGraph[item] = exchanges.createVertex(data: item)
        }
        
        rates.forEach { rate in
            exchanges.add(.directed, from: exchangeGraph[rate.from]!, to: exchangeGraph[rate.to]!, weight: 1)
        }
    }
    
    private func getConversionRate(from: String, to: String) -> Double? {
        var rate: Double?
        if let edges = exchanges.breadthFirstSearch(from: exchangeGraph[from]!, to: exchangeGraph[to]!) {
            for edge in edges {
                if let convertion = rates.first(where: { $0.from == edge.source.description && $0.to == edge.destination.description }), let convertionRate = Double(convertion.rate) {
                    if rate == nil {
                        rate = convertionRate
                    } else {
                        rate = rate! * convertionRate
                    }
                }
            }
            
            return rate
        }
        
        return nil
    }
    
}

extension TransactionInfoPresenter: TransactionInfoPresenterProtocol {
    
    func prepareView() {
        getAllRates()
        
        let convertedTransactions = convertTransactionsToEuros(transactions: transactions)
        let viewModel = TransactionInfo.ViewModel(title: transactions.first!.sku,
                                                  transactions: convertedTransactions,
                                                  total: "TOTAL: \(total) EUR")
        
        viewController.show(viewModel: viewModel)
    }

}

struct Convertion: Hashable {
    let from: String
    let to: String
}
