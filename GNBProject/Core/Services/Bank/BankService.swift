//
//  BankService.swift
//  GNBProject
//
//  Created by Brais Castro on 6/5/22.
//

import Foundation
import Alamofire

final class BankService {
    
    private enum BankServiceAPI {
        
        case rates
        case transactions
        
        func headers() -> HTTPHeaders {
            
            switch self {
            case .rates, .transactions:
                return [
                    .accept("application/json")
                ]
            }
        }
        
        func url() -> URL? {
            
            switch self {
            case .rates:
                return URL(string: "\(Constants.kBaseUrl)/rates")
            case .transactions:
                return URL(string: "\(Constants.kBaseUrl)/transactions")
            }
        }
    }
    
    func rates(success: @escaping (_ launch: [Bank.Rate]) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        guard let url = BankServiceAPI.rates.url() else {
            failure(nil)
            return
        }
        
        AF.request(url, headers: BankServiceAPI.rates.headers())
            .responseDecodable(of: [Bank.Rate].self) { response in
                if let current = response.value {
                    success(current)
                    return
                }
                
                failure(response.error)
        }
    }
    
    func transactions(success: @escaping (_ launch: [Bank.Transaction]) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        guard let url = BankServiceAPI.transactions.url() else {
            failure(nil)
            return
        }
        
        AF.request(url, headers: BankServiceAPI.rates.headers())
            .responseDecodable(of: [Bank.Transaction].self) { response in
                if let current = response.value {
                    success(current)
                    return
                }
                
                failure(response.error)
        }
    }
    
}
