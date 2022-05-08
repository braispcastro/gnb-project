//
//  TransactionListPresenterTest.swift
//  GNBProjectTests
//
//  Created by Brais Castro on 8/5/22.
//

import XCTest
import Nimble
@testable import GNBProject

class TransactionListPresenterTest: XCTestCase {
    
    private var sut: TransactionListPresenter!
    private var spyRouter: SpyRouter!
    private var spyViewController: SpyViewController!
    private var mockTransactionListInteractor: MockTransactionListInteractor!
    
    override func setUp() {
        super.setUp()
        spyViewController = SpyViewController()
        spyRouter = SpyRouter()
        mockTransactionListInteractor = MockTransactionListInteractor()
        givenSut()
    }

    override func tearDown() {
        spyViewController = nil
        spyRouter = nil
        sut = nil
        mockTransactionListInteractor = nil
        super.tearDown()
    }
    
    // MARK: - Private methods
    
    private func givenSut() {
        sut = TransactionListPresenter(viewController: spyViewController,
                                       router: spyRouter,
                                       interactor: mockTransactionListInteractor)
    }
    
    private func mockTransactions() -> [Bank.Transaction] {
        return [
            Bank.Transaction(sku: "SKU1", amount: "13.5", currency: "EUR"),
            Bank.Transaction(sku: "SKU2", amount: "6.8", currency: "USD"),
            Bank.Transaction(sku: "SKU3", amount: "17.23", currency: "CAD"),
            Bank.Transaction(sku: "SKU4", amount: "54.1", currency: "AUD")
        ]
    }
    
    private func mockRates() -> [Bank.Rate] {
        return [
            Bank.Rate(from: "EUR", to: "USD", rate: "1.05"),
            Bank.Rate(from: "USD", to: "EUR", rate: "0.95")
        ]
    }
    
    // MARK: - Test methods
    
    func test_user_enters_transaction_list_screen_and_backend_call_are_made() {
        sut.prepareView()
        
        expect(self.mockTransactionListInteractor.getRatesCalled).toEventually(equal(1))
        expect(self.mockTransactionListInteractor.getTransactionsCalled).toEventually(equal(1))
    }
    
    func test_user_enters_transaction_list_screen_and_it_has_expected_content() {
        sut.prepareView()
        
        let expectedViewModel = TransactionList.ViewModel(title: "Transactions")
        expect(self.spyViewController.viewModel).toEventually(equal(expectedViewModel))
        expect(self.spyViewController.showCalled).toEventually(equal(1))
    }
    
    func test_user_selects_transaction_then_navigates_to_info_view() {
        sut.prepareView()
        sut.transactions(mockTransactions())
        sut.transactionSelected(name: "SKU1")
        
        expect(self.spyRouter.navigateToInformationCalled).toEventually(equal(1))
    }
    
    func test_transactions_and_rates_call_fails_then_error_alert_shown() {
        sut.prepareView()
        sut.rates(mockRates())
        sut.error("Unknown error")
        
        expect(self.spyRouter.showAlertCalled).toEventually(equal(1))
    }
    
    func test_transactions_and_rates_call_ok_then_error_alert_not_shown() {
        sut.prepareView()
        sut.rates(mockRates())
        sut.transactions(mockTransactions())
        
        expect(self.spyRouter.showAlertCalled).toEventually(equal(0))
    }
    
    func test_transactions_and_rates_call_ok_then_error_alert_not_shown2() {
        sut.prepareView()
        sut.transactions(mockTransactions())
        sut.rates(mockRates())
        
        expect(self.spyRouter.showAlertCalled).toEventually(equal(0))
    }
    
}

// MARK: - TransactionListViewControllerProtocol
private class SpyViewController: TransactionListViewControllerProtocol {
    
    var showCalled: Int = 0
    var showTransactionsCalled: Int = 0
    var stopActivityIndicatorCalled: Int = 0
    
    var viewModel: TransactionList.ViewModel?
    
    func show(viewModel: TransactionList.ViewModel) {
        showCalled += 1
        self.viewModel = viewModel
    }
    
    func showTransactions(transactionList: [TransactionList.TransactionViewModel]) {
        showTransactionsCalled += 1
    }
    
    func stopActivityIndicator() {
        stopActivityIndicatorCalled += 1
    }
    
}

// MARK: - TransactionListRouterProtocol
private class SpyRouter: TransactionListRouterProtocol {
    
    var showAlertCalled: Int = 0
    var navigateToInformationCalled: Int = 0
    
    func showAlert(message: String) {
        showAlertCalled += 1
    }
    
    func navigateToInformation(transactions: [Bank.Transaction], rates: [Bank.Rate]) {
        navigateToInformationCalled += 1
    }
    
}

// MARK: - TransactionListInteractorProtocol
private final class MockTransactionListInteractor: TransactionListInteractorProtocol {
    
    var getRatesCalled: Int = 0
    var getTransactionsCalled: Int = 0
    
    func getRates() {
        getRatesCalled += 1
    }
    
    func getTransactions() {
        getTransactionsCalled += 1
    }
    
}
