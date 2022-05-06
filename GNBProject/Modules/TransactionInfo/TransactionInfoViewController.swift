//
//  TransactionInfoViewController.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import UIKit

final class TransactionInfoViewController: BaseViewController {

    var presenter: TransactionInfoPresenterProtocol!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    // MARK: - ViewLife Cycle
    

    // MARK: - Setup

    override func setupComponents() {

    }

    override func setupConstraints() {
        
    }

    // MARK: - Actions
    

    // MARK: Private Methods

}

// MARK: - TransactionInfoViewControllerProtocol
extension TransactionInfoViewController: TransactionInfoViewControllerProtocol {
 
}
