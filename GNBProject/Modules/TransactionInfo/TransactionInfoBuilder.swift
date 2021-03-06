//
//  TransactionInfoBuilder.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation
import UIKit.UIViewController

final class TransactionInfoBuilder {

    static func build(transactions: [Bank.Transaction], rates: [Bank.Rate]) -> UIViewController {

        let viewController: TransactionInfoViewController = TransactionInfoViewController()
        let presenter: TransactionInfoPresenter = TransactionInfoPresenter(viewController: viewController,
                                                                           rates: rates,
                                                                           transactions: transactions)
        
        viewController.presenter = presenter

        return viewController
    }

}
