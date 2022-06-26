//
//  Real+Extension.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 29/04/2022.
//

import Foundation
import RealmSwift

extension RealmCollection
{
  func toArray<T>() ->[T]
  {
    return self.compactMap{$0 as? T}
  }
}
