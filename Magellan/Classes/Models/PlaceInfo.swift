/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

struct Schedule: Codable, Equatable {
    
    let open24: Bool
    let workDays: [WorkingDay]?
    
}

struct WorkingDay: WorkingStatusProtocol, Codable, Equatable {

    var day: String? {
        return Calendar.current.shortStandaloneWeekdaySymbols[dayOfWeek.numberOfWeek]
    }


    struct Time: Codable, Equatable {
        let hour: Int
        let minute: Int
        
        var description: String {
            let minutesValue = minute < 10 ? "0\(minute)" : String(minute)
            return "\(hour):\(minutesValue)"
        }
    }
    
    enum Day: String, Codable {
        case Monday = "MONDAY"
        case Tuesday = "TUESDAY"
        case Wednesday = "WEDNESDAY"
        case Thursday = "THURSDAY"
        case Friday = "FRIDAY"
        case Saturday = "SATURDAY"
        case Sunday = "SUNDAY"
        
        var numberOfWeek: Int {
            switch self {
            case .Monday:
                return 1
            case .Tuesday:
                return 2
            case .Wednesday:
                return 3
            case .Thursday:
                return 4
            case .Friday:
                return 5
            case .Saturday:
                return 6
            case .Sunday:
                return 0
            }
        }
    }
    
    let dayOfWeek: Day
    let from: Time
    let to: Time
    let launchTimeFrom: Time?
    let launchTimeTo: Time?
    
    var currentDate: Date {
        return Date()
    }

    var opensTime: String {
        return from.description
    }
    
    var closesTime: String {
        return to.description
    }
    
    var workingHours: String {
        return "\(from.description) - \(to.description)"
    }
    
    var startLaunchTime: String? {
        return launchTimeFrom?.description
    }
    var finishLaunchTime: String? {
        return launchTimeTo?.description
    }
    
    var launchHours: String? {
        guard let launchTimeFrom = launchTimeFrom,
            let launchTimeTo = launchTimeTo else {
                return nil
        }
        return "\(launchTimeFrom.description) - \(launchTimeTo.description)"
    }
    
    var startLaunchTimeInterval: TimeInterval? {
        guard let launchTimeFrom = launchTimeFrom else {
            return nil
        }
        let seconds = Int64(launchTimeFrom.hour * 60 * 60 + launchTimeFrom.minute * 60)
        return TimeInterval(integerLiteral: seconds)
    }
    
    var finishLaunchTimeInterval: TimeInterval?  {
        guard let launchTimeTo = launchTimeTo else {
            return nil
        }
        let seconds = Int64(launchTimeTo.hour * 60 * 60 + launchTimeTo.minute * 60)
        return TimeInterval(integerLiteral: seconds)
    }
    
    var opensTimeInterval: TimeInterval {
        let seconds = Int64(from.hour * 60 * 60 + from.minute * 60)
        return TimeInterval(integerLiteral: seconds)
    }
    
    var closesTimeInterval: TimeInterval {
        let seconds = Int64(to.hour * 60 * 60 + to.minute * 60)
        return TimeInterval(integerLiteral: seconds)
    }
    
}

struct PlaceInfo: Coordinated {
    
    let id: String
    let name: String
    let type: String
    let khmerType: String?
    let coordinates: Coordinates
    let address: String
    let phoneNumber: String?
    let region: String?
    let website: String?
    let facebook: String?
    let logoUuid: String?
    let promoImageUuid: String?
    let distance: String?
    let workSchedule: Schedule?
}

extension PlaceInfo {

    var weekDayNumber: Int {
        return Calendar.current.component(.weekday, from: Date()) - 1
    }

    var currentWorkingDay: WorkingDay? {
        return workSchedule?
            .workDays?
            .first(where: { $0.dayOfWeek.numberOfWeek == weekDayNumber })
    }

    var nextWorkingDay: WorkingDay? {
        let nextDayNumber = weekDayNumber == 6 ? 0 : weekDayNumber + 1
        return workSchedule?
            .workDays?
            .first(where: { $0.dayOfWeek.numberOfWeek == nextDayNumber })
    }
    
    var isOpen: Bool {
        
        if workSchedule?.open24 == true {
            return true
        }
        
        if let currentWorkingDay = currentWorkingDay {
            return currentWorkingDay.isOpen
        }
        
        return false
        
    }
    
    func workingStatus(with resources: WorkingStatusResources) -> String {
        if workSchedule?.open24 == true {
            return resources.open
        }

        if let currentWorkingDay = currentWorkingDay,
            let status = currentWorkingDay.status(with: resources, nextWorkingDay: nextWorkingDay) {
            return status
        }
        
        return ""
    }
}

extension PlaceInfo: Codable { }
extension PlaceInfo: Equatable {
    static func == (lhs: PlaceInfo, rhs: PlaceInfo) -> Bool {
        return lhs.id == rhs.id
    }
}
