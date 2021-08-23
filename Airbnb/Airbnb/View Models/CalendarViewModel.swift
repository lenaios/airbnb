//
//  CalendarViewModel.swift
//  Airbnb
//
//  Created by Ador on 2021/07/24.
//

import Foundation

class CalendarViewModel {
  var calendar = Calendar(identifier: .gregorian)
  
  let checkin = Box<Date>()
  let checkout = Box<Date>()
  
  func selectDate(date: Date) {
    guard let _ = checkin.value, let _ = checkout.value else {
      if let checkin = checkin.value, checkin < date {
        checkout.value = date
      } else {
        checkin.value = date
      }
      return
    }
    self.checkin.value = date
    self.checkout.value = nil
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
    let shiftedDate = calendar.date(byAdding: .month, value: indexPath.section, to: Date())!
    let year = calendar.component(.year, from: shiftedDate)
    return year
  }
  
  func month(at indexPath: IndexPath) -> Int {
    let shiftedDate = calendar.date(byAdding: .month, value: indexPath.section, to: Date())!
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
  
  func date(at indexPath: IndexPath) -> Date? {
    let year = year(at: indexPath)
    let month = month(at: indexPath)
    guard let day = day(at: indexPath) else { return nil }
    let dateComponents = DateComponents(calendar: calendar, year: year, month: month, day: day)
    return calendar.date(from: dateComponents)
  }
}
