//
//  TransactionInfoBuilder.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation
import UIKit.UIViewController

final class TransactionInfoBuilder {

    static func build() -> UIViewController {

        let viewController: TransactionInfoViewController = TransactionInfoViewController()
        let router: TransactionInfoRouter = TransactionInfoRouter(viewController: viewController)
        let presenter: TransactionInfoPresenter = TransactionInfoPresenter(viewController: viewController, router: router)
        viewController.presenter = presenter

        return viewController
    }

}
