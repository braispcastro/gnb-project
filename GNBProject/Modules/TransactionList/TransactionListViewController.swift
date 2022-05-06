//
//  TransactionListViewController.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import UIKit

final class TransactionListViewController: BaseViewController {

    var presenter: TransactionListPresenterProtocol!

    // MARK: - Component Declaration

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public enum AccessibilityIds {
        
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

// MARK: - TransactionListViewControllerProtocol
extension TransactionListViewController: TransactionListViewControllerProtocol {
 
}
