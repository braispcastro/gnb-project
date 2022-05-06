//
//  TransactionListBuilder.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation
import UIKit.UIViewController

final class TransactionListBuilder {

    static func build() -> UIViewController {

        let viewController: TransactionListViewController = TransactionListViewController()
        let router: TransactionListRouter = TransactionListRouter(viewController: viewController)
        let presenter: TransactionListPresenter = TransactionListPresenter(viewController: viewController, router: router)
        viewController.presenter = presenter

        return viewController
    }

}
