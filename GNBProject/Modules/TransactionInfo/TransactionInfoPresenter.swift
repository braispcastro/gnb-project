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

}

final class TransactionInfoPresenter<T: TransactionInfoViewControllerProtocol, U: TransactionInfoRouterProtocol> {
    
    private let viewController: TransactionInfoViewControllerProtocol!
    private let router: TransactionInfoRouterProtocol!

    init(viewController: T, router: U) {
        self.viewController = viewController
        self.router = router
    }
    
}

extension TransactionInfoPresenter: TransactionInfoPresenterProtocol {

}
