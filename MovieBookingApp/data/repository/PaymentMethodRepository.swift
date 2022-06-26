//
//  SnackRepository.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 05/05/2022.
//

import Foundation

protocol PaymentMethodRepository {
    // For Snack
    func saveSnacks(data: [SnackObject])
    func getSnacks(completion: @escaping ([SnackObject]) -> Void)
    
    //For payment method
    func savePaymentMethod(data: [PaymentMethodObject])
    func getPaymentMethod(completion: @escaping ([PaymentMethodObject]) -> Void )
    
    //Card
    func saveCards(data: [CardObject])
    func getCards(completion: @escaping ([CardObject]) -> Void )
    
    func saveTicket(data: TicketObject)
    func getTickets(completion: @escaping ([TicketObject]) -> Void )
    func getTicket(id: Int, completion: @escaping (TicketObject) -> Void )
}

class PaymentMethodRepositoryImpl: BaseRepository, PaymentMethodRepository {
    
    static let shared : PaymentMethodRepository = PaymentMethodRepositoryImpl()
    private override init() { }
    
    func saveSnacks(data: [SnackObject]) {
        do {
            try realmInstance.write({
                realmInstance.add(data, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getSnacks(completion: @escaping ([SnackObject]) -> Void) {
        completion(Array(realmInstance.objects(SnackObject.self)))
    }
    
    func savePaymentMethod(data: [PaymentMethodObject]) {
        do {
            try realmInstance.write( {
                realmInstance.add(data, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getPaymentMethod(completion: @escaping ([PaymentMethodObject]) -> Void) {
        completion(Array(realmInstance.objects(PaymentMethodObject.self)))
    }
    
    func saveCards(data: [CardObject]) {
        do {
            try realmInstance.write({
                realmInstance.add(data, update: .modified)
            })
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getCards(completion: @escaping ([CardObject]) -> Void) {
        completion(Array(realmInstance.objects(CardObject.self)))
    }
    
    func saveTicket(data: TicketObject) {
        do {
            try realmInstance.write( {
                realmInstance.add(data, update: .modified)
            })
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getTickets(completion: @escaping ([TicketObject]) -> Void) {
        completion(Array(realmInstance.objects(TicketObject.self).sorted(byKeyPath: "bookingDate", ascending: false)))
    }
    
    func getTicket(id: Int, completion: (TicketObject) -> Void ) {
        guard let ticket = realmInstance.object(ofType: TicketObject.self, forPrimaryKey: id) else { return }
        completion(ticket)
    }
    
}
