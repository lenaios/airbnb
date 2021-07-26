//
//  CalendarViewModel.swift
//  Airbnb
//
//  Created by Ador on 2021/07/24.
//

import Foundation

class CalendarViewModel {
    enum SelectedMode {
        case none
        case one
        case all
    }
    
    var selectHandler: (([IndexPath]) -> Void)?
    
    var calendar = Calendar(identifier: .gregorian)
    
    private var selectedMode: SelectedMode = .none
    
    private let today = Date()
    
    private var start: IndexPath?
    private var end: IndexPath?
    
    private var startDate: Date?
    private var endDate: Date?
    
    func select(at indexPath: IndexPath) {
        let date = date(at: indexPath)
        switch selectedMode {
        case .none:
            startDate = date
            start = indexPath
            selectedMode = .one
        case .one:
            if let _ = startDate, startDate! < date {
                endDate = date
                end = indexPath
            } else {
                end = start
                endDate = startDate
                start = indexPath
                startDate = date
            }
            selectedMode = .all
        case .all:
            startDate = date
            endDate = nil
            start = indexPath
            end = nil
            selectedMode = .one
            selectHandler?([start!])
        }
    }
    
    func deselect() {
        start = nil
        end = nil
        startDate = nil
        endDate = nil
        selectedMode = .none
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
