//
//  TransactionInfoPresenterTest.swift
//  GNBProjectTests
//
//  Created by Brais Castro on 8/5/22.
//

import XCTest
import Nimble
@testable import GNBProject

class TransactionInfoPresenterTest: XCTestCase {
    
    private var sut: TransactionInfoPresenter!
    private var spyViewController: SpyViewController!
    
    override func setUp() {
        super.setUp()
        spyViewController = SpyViewController()
        givenSut()
    }

    override func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Private methods
    
    private func givenSut() {
        sut = TransactionInfoPresenter(viewController: spyViewController,
                                       rates: mockRates(),
                                       transactions: mockTransactions())
    }
    
    private func mockTransactions() -> [Bank.Transaction] {
        return [
            Bank.Transaction(sku: "SKU1", amount: "23.5", currency: "EUR"),
            Bank.Transaction(sku: "SKU1", amount: "24.5", currency: "EUR"),
            Bank.Transaction(sku: "SKU1", amount: "9.8", currency: "USD"),
            Bank.Transaction(sku: "SKU1", amount: "20.8", currency: "CAD")
        ]
    }
    
    private func mockRates() -> [Bank.Rate] {
        return [
            Bank.Rate(from: "EUR", to: "USD", rate: "1.05"),
            Bank.Rate(from: "USD", to: "EUR", rate: "0.95"),
            Bank.Rate(from: "USD", to: "CAD", rate: "1.29"),
            Bank.Rate(from: "CAD", to: "USD", rate: "0.78")
        ]
    }
    
    // MARK: - Test methods
    
    func test_user_enters_transaction_info_screen_and_it_has_expected_content() {
        sut.prepareView()
        
        let transactions: [TransactionInfo.Transaction] = [
            TransactionInfo.Transaction(sku: "SKU1 - 23.5 EUR", euros: "Converted value: 24 EUR"),
            TransactionInfo.Transaction(sku: "SKU1 - 24.5 EUR", euros: "Converted value: 24 EUR"),
            TransactionInfo.Transaction(sku: "SKU1 - 9.8 USD", euros: "Converted value: 9 EUR"),
            TransactionInfo.Transaction(sku: "SKU1 - 20.8 CAD", euros: "Converted value: 15 EUR")
        ]
        let expectedViewModel = TransactionInfo.ViewModel(title: "SKU1",
                                                          transactions: transactions,
                                                          total: "TOTAL: 72 EUR")
        
        expect(self.spyViewController.viewModel).toEventually(equal(expectedViewModel))
        expect(self.spyViewController.showCalled).toEventually(equal(1))
    }
    
}

// MARK: - TransactionInfoViewControllerProtocol
private class SpyViewController: TransactionInfoViewControllerProtocol {
    
    var showCalled: Int = 0
    
    var viewModel: TransactionInfo.ViewModel?
    
    func show(viewModel: TransactionInfo.ViewModel) {
        showCalled += 1
        self.viewModel = viewModel
    }
    
}
