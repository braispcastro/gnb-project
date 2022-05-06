//
//  TransactionListViewController.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - ViewLife Cycle
    /*
     Order:
     - viewDidLoad
     - viewWillAppear
     - viewDidAppear
     - viewWillDisapear
     - viewDidDisappear
     - viewWillLayoutSubviews
     - viewDidLayoutSubviews
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()
        setupConstraints()
        
        setupNavigationItem()
        setupView()
    }
    
    // MARK: - Setup
    
    func setupComponents() {
        fatalError("Missing implementation of \"setupComponents\"")
    }

    func setupConstraints() {
        fatalError("Missing implementation of \"setupConstraints\"")
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
    }
}
