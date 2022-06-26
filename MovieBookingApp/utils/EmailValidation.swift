//
//  EmailValidation.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 12/05/2022.
//

import Foundation

class EmailValidation {
    func isValidEmail(_ email: String) -> Bool {
    let result = email.range(
        of: #"^\S+@\S+\.\S+$"#,
        options: .regularExpression
    )

    return result != nil
    }
}
