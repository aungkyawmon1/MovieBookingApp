// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileResponse = try? newJSONDecoder().decode(ProfileResponse.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - DataClass
class ProfileObject : Object, Codable {
    @Persisted(primaryKey: true)
    var id: Int?
    
    @Persisted
    var name: String?
    
    @Persisted
    var email: String?
    
    @Persisted
    var phone: String?
    
    @Persisted
    var totalExpense: Int?
    
    @Persisted
    var profileImage: String?
    
    @Persisted
    var cards: List<CardObject>

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone
        case totalExpense = "total_expense"
        case profileImage = "profile_image"
        case cards
    }


}
