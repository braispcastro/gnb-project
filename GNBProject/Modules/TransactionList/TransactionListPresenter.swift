//
//  TransactionListPresenter.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation

protocol TransactionListViewControllerProtocol {

}

protocol TransactionListPresenterProtocol {

}

final class TransactionListPresenter<T: TransactionListViewControllerProtocol, U: TransactionListRouterProtocol> {
    
    private let viewController: TransactionListViewControllerProtocol!
    private let router: TransactionListRouterProtocol!

    init(viewController: T, router: U) {
        self.viewController = viewController
        self.router = router
    }
    
}

extension TransactionListPresenter: TransactionListPresenterProtocol {

}
