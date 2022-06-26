//
//  SnackModel.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 05/05/2022.
//

import Foundation

protocol PaymentMethodModel {
    func getSnacks(completion: @escaping (MDBResult<[SnackObject]>) -> Void)
    func getPaymentMethod(completion: @escaping (MDBResult<[PaymentMethodObject]>) -> Void )
    
    //
    func getCards(completion: @escaping (MDBResult<[CardObject]>) -> Void)
    func registerCard(cardNumber: String , cardHolder: String, expirationDate: String, cvc: String, completion: @escaping (MDBResult<[CardObject]>) -> Void )
    
    func registerTicket(checkout: CheckOutVO, completion: @escaping (MDBResult<TicketObject>) -> Void )
    func getTicket(id: Int, completion: @escaping (MDBResult<TicketObject>) -> Void )
    func getTickets(completion: @escaping (MDBResult<[TicketObject]>) -> Void )
}

class PaymentMethodModelImpl: BaseModel, PaymentMethodModel {

    static let shared = PaymentMethodModelImpl()
    private override init() { }

    let paymentMethod : PaymentMethodRepository = PaymentMethodRepositoryImpl.shared
    
    func getSnacks(completion: @escaping (MDBResult<[SnackObject]>) -> Void) {
        networkAgent.getSnacks { result in
            switch result {
            case .success(let data):
                self.paymentMethod.saveSnacks(data: data)
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.paymentMethod.getSnacks {
                completion(.success($0))
            }
        }
    }
    
    func getPaymentMethod(completion: @escaping (MDBResult<[PaymentMethodObject]>) -> Void ) {
        networkAgent.getPaymentMethod { result in
            switch result {
            case .success(let data):
                self.paymentMethod.savePaymentMethod(data: data)
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.paymentMethod.getPaymentMethod {
                completion(.success($0))
            }
        }
    }
    
    func registerCard(cardNumber: String, cardHolder: String, expirationDate: String, cvc: String, completion: @escaping (MDBResult<[CardObject]>) -> Void) {
        networkAgent.registerCard(cardNumber: cardNumber, cardHolder: cardHolder, expirationDate: expirationDate, cvc: cvc) { result in
            switch result {
            case .success(let data):
                self.paymentMethod.saveCards(data: data)
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
            self.paymentMethod.getCards { completion(.success($0)) }
        }
    }
    
    func getCards(completion: @escaping (MDBResult<[CardObject]>) -> Void) {
        paymentMethod.getCards { completion(.success( $0 ) ) }
    }
    
    func registerTicket(checkout: CheckOutVO, completion: @escaping (MDBResult<TicketObject>) -> Void) {
        networkAgent.registerTicket(checkOut: checkout) { result in
            switch result {
            case .success(let data):
                self.paymentMethod.saveTicket(data: data)
                completion(.success(data))
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    func getTicket(id: Int, completion: @escaping (MDBResult<TicketObject>) -> Void ) {
        paymentMethod.getTicket(id: id) { completion(.success( $0 ))}
    }
    
    func getTickets(completion: @escaping (MDBResult<[TicketObject]>) -> Void) {
        paymentMethod.getTickets { completion(.success( $0 ))}
    }
    
}
