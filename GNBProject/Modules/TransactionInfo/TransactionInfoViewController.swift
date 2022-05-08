//
//  TransactionInfoViewController.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import UIKit

final class TransactionInfoViewController: BaseViewController {

    var presenter: TransactionInfoPresenterProtocol!
    private var viewModel: TransactionInfo.ViewModel!

    // MARK: - Component Declaration
    
    private var totalLabel: UILabel!
    private var tableView: UITableView!

    private enum ViewTraits {
        static let margins = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16)
    }

    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.prepareView()
    }
    

    // MARK: - Setup

    override func setupComponents() {
        totalLabel = UILabel()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalLabel)
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupConstraints() {
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewTraits.margins.top),
            totalLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: ViewTraits.margins.left),
            totalLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: ViewTraits.margins.right),
            
            tableView.topAnchor.constraint(equalTo: totalLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Actions
    

    // MARK: Private Methods

}

// MARK: - TransactionInfoViewControllerProtocol
extension TransactionInfoViewController: TransactionInfoViewControllerProtocol {
 
    func show(viewModel: TransactionInfo.ViewModel) {
        self.viewModel = viewModel
        self.title = viewModel.title
        totalLabel.text = viewModel.total
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TransactionInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*guard let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            fatalError("Not registered for tableView")
        }*/
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let item = viewModel.transactions[indexPath.row]
        cell.textLabel?.text = item.sku
        cell.detailTextLabel?.text = "\(item.euros)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
