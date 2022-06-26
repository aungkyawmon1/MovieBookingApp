//
//  MyDate.swift
//  MovieBookingApp
//
//  Created by MacBook Pro on 03/05/2022.
//

import Foundation

struct MyDate {
    let day: Int
    let date: String
    let week : String
    
    static func comingNextDat() -> [MyDate] {
            let today = Calendar.current
            var dateList = [Date()]
            
            for i in 1...9 {
                let nextDate = today.date(byAdding: .day, value: i, to: Date())!
                dateList.append(nextDate)
            }

            return dateList.map { date -> MyDate in
                let day = today.component(.day, from: date)
                let shortWeek = DateFormatter().shortWeekdaySymbols[today.component(.weekday, from: date) - 1]
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let complete = dateFormatter.string(from: date)
                
                return MyDate(day: day, date: complete, week: shortWeek)
            }
        }
}
