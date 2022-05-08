//
//  TransactionListRouter.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation
import UIKit

protocol TransactionListRouterProtocol {
    func showAlert(message: String)
    func navigateToInformation(transactions: [Bank.Transaction], rates: [Bank.Rate])
}

class TransactionListRouter: TransactionListRouterProtocol {
    
    private let viewController: TransactionListViewController!
    
    init(viewController: TransactionListViewController) {
        self.viewController = viewController
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: nil))
        viewController.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func navigateToInformation(transactions: [Bank.Transaction], rates: [Bank.Rate]) {
        let vc = TransactionInfoBuilder.build(transactions: transactions, rates: rates)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

}
