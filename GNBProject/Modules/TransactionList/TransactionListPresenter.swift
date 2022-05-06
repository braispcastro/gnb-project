//
//  TransactionListPresenter.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

protocol TransactionListViewControllerProtocol {
    func show(viewModel: TransactionList.ViewModel)
    func showTransactions(transactionList: [TransactionList.TransactionViewModel])
    func backendError(error: String)
}

protocol TransactionListPresenterProtocol {
    func prepareView()
    func transactionSelected(name: String)
}

final class TransactionListPresenter {
    
    private let viewController: TransactionListViewControllerProtocol!
    private let interactor: TransactionListInteractorProtocol!
    private let router: TransactionListRouterProtocol!
    
    private var rates: [Bank.Rate] = []
    private var transactions: [Bank.Transaction] = []

    init(viewController: TransactionListViewControllerProtocol,
         router: TransactionListRouterProtocol,
         interactor: TransactionListInteractorProtocol) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Private Methods
    
    private func buildTransactions() {
        let uniqueTransactions = Array(Set(transactions.map { TransactionList.TransactionViewModel(name: $0.sku) }))
        viewController.showTransactions(transactionList: uniqueTransactions)
    }
    
}

// MARK: - TransactionListPresenterProtocol
extension TransactionListPresenter: TransactionListPresenterProtocol {

    func prepareView() {
        interactor.getRates()
        interactor.getTransactions()
        
        let viewModel = TransactionList.ViewModel(title: "Transactions")
        viewController.show(viewModel: viewModel)
    }
    
    func transactionSelected(name: String) {
        let transactionsFiltered = transactions.filter { $0.sku == name }
        router.navigateToInformation(transactions: transactionsFiltered, rates: rates)
    }
    
}

// MARK: - TransactionListInteractorCallbackProtocol
extension TransactionListPresenter: TransactionListInteractorCallbackProtocol {
    
    func rates(_ rates: [Bank.Rate]) {
        self.rates = rates
        if !transactions.isEmpty {
            buildTransactions()
        }
    }
    
    func transactions(_ transactions: [Bank.Transaction]) {
        self.transactions = transactions
        if !rates.isEmpty {
            buildTransactions()
        }
    }
    
    func error(_ error: String?) {
        let err: String = error ?? "Unknown error"
        viewController.backendError(error: err)
    }
    
}
