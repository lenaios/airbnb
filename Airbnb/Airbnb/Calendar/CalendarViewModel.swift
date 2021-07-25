//
//  CalendarViewModel.swift
//  Airbnb
//
//  Created by Ador on 2021/07/24.
//

import Foundation

class CalendarViewModel {
    
    var selectHandler: (([IndexPath]) -> Void)?
    
    var calendar = Calendar(identifier: .gregorian)
    
    private let today = Date()
    
    var start: IndexPath? {
        willSet {
            guard let value = newValue else {
                startDate = nil
                return
            }
            startDate = date(at: value)
        }
    }
    var end: IndexPath? {
        willSet {
            guard let value = newValue else {
                endDate = nil
                return
            }
            endDate = date(at: value)
        }
    }
    
    var startDate: Date?
    
    var endDate: Date?
    
    func select(at indexPath: IndexPath) {
        let date = date(at: indexPath)
        if start == nil && end == nil {
            start = indexPath
        } else if let _  = startDate, startDate! < date {
            end = indexPath
        } else {
            end = start
            start = indexPath
        }
        guard let start = start, let end = end else {
            return
        }
        selectHandler?([start, end])
    }
    
    func deselect(at indexPath: IndexPath) {
        let date = date(at: indexPath)
        if startDate == date {
            start = nil
        }
        if endDate == date {
            end = nil
        }
    }
}

extension CalendarViewModel {
    func dayOffset(year: Int, month: Int) -> Int {
        let firstOfMonthDateComponents = DateComponents(calendar: calendar, year: year, month: month, day: 1)
        let startOfMonth = calendar.date(from: firstOfMonthDateComponents)!
        let dayOffset = calendar.component(.weekday, from: startOfMonth) - 1
        return dayOffset
    }
    
    func year(at indexPath: IndexPath) -> Int {
        let shiftedDate = calendar.date(byAdding: .month, value: indexPath.section, to: today)!
        let year = calendar.component(.year, from: shiftedDate)
        return year
    }
    
    func month(at indexPath: IndexPath) -> Int {
        let shiftedDate = calendar.date(byAdding: .month, value: indexPath.section, to: today)!
        let month = calendar.component(.month, from: shiftedDate)
        return month
    }
    
    func day(at indexPath: IndexPath) -> Int? {
        let year = self.year(at: indexPath)
        let month = self.month(at: indexPath)
        let day = indexPath.item - dayOffset(year: year, month: month) + 1
        guard day >= 1 else {
            return nil
        }
        return day
    }
    
    func date(at indexPath: IndexPath) -> Date {
        let year = year(at: indexPath)
        let month = month(at: indexPath)
        let day = day(at: indexPath)
        let dateComponents = DateComponents(calendar: calendar, year: year, month: month, day: day)
        return calendar.date(from: dateComponents)!
    }
}
