//
//  BelongsToTypeObject.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 27/04/2022.
//

import Foundation

import Foundation
import RealmSwift

class BelongsToTypeObject : Object {
    @Persisted(primaryKey: true)
    var name: String?
    
    @Persisted(originProperty: "belongsToType")
    var movies: LinkingObjects<MovieObject>
}

enum MovieSerieGroupType : String, CaseIterable {
    case nowShowing = "Now Showing"
    case comingSoon = "Coming Soon"
}
