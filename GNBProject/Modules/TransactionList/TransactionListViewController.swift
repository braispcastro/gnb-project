//
//  TransactionListViewController.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import UIKit

final class TransactionListViewController: BaseViewController {

    var presenter: TransactionListPresenterProtocol!
    private var viewModel: TransactionList.ViewModel!
    private var transactionList: [TransactionList.TransactionViewModel] = []

    // MARK: - Component Declaration
    private var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        presenter.prepareView()
    }
    

    // MARK: - Setup

    override func setupComponents() {        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Actions
    

    // MARK: Private Methods

}

// MARK: - TransactionListViewControllerProtocol
extension TransactionListViewController: TransactionListViewControllerProtocol {
 
    func show(viewModel: TransactionList.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
    }
    
    func showTransactions(transactionList: [TransactionList.TransactionViewModel]) {
        self.transactionList = transactionList
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func backendError(error: String) {
        //TODO: Show error alert
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TransactionListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            fatalError("Not registered for tableView")
        }
        
        cell.textLabel?.text = transactionList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
