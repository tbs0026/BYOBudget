//
//  Extensions.swift
//  BYOB
//
//  Created by Trevor Smith on 8/15/19.
//  Copyright © 2019 Trevor Smith. All rights reserved.
//

import UIKit
import SystemConfiguration
import UserNotifications

class StaticFunctions {

    static func getMonthlyMyPlanKey() -> String {
        let thisMonth = Date().monthName(.default)
        let thisYear = Date().year
        let thisMonthKey = "MyPlanArray\(thisMonth)\(thisYear)"
        print("\(thisMonthKey)")
        return thisMonthKey
    }

    static func getMonthlyExpensesKey() -> String {
        let thisMonth = Date().monthName(.default)
        let thisYear = Date().year
        let thisMonthKey = "ExpenseArray\(thisMonth)\(thisYear)"
        return thisMonthKey
    }

    static func decodeGroupArray() -> [MyPlanObject] {
        var array: [MyPlanObject] = []
        if let JSONStringIn = UserDefaults.standard.string(forKey: getMonthlyMyPlanKey()) {
            if let JSONData = JSONStringIn.data(using: .utf8) {
                let cachedArray = try? JSONDecoder().decode([MyPlanObject].self, from: JSONData)
                array = cachedArray ?? []
            }
        }
        return array
    }

    static func decodeExpenseArray() -> [ExpenseObject] {
        var array: [ExpenseObject] = []
        if let JSONStringIn = UserDefaults.standard.string(forKey: getMonthlyExpensesKey()) {
            if let JSONData = JSONStringIn.data(using: .utf8) {
                let cachedArray = try? JSONDecoder().decode([ExpenseObject].self, from: JSONData)
                array = cachedArray ?? []
            }
        }
        return array
    }

    static func getTotalMaxBudget() -> Double {
        var array: [MyPlanObject] = []
        if let JSONStringIn = UserDefaults.standard.string(forKey: getMonthlyMyPlanKey()) {
            if let JSONData = JSONStringIn.data(using: .utf8) {
                let cachedArray = try? JSONDecoder().decode([MyPlanObject].self, from: JSONData)
                array = cachedArray ?? []
            }
        }
        var amount = 0.0
        for i in array {
            amount += i.maxAmount
        }
        return amount
    }

    static func getTotalAmountSpent() -> Double {
        var array: [MyPlanObject] = []
        if let JSONStringIn = UserDefaults.standard.string(forKey: getMonthlyMyPlanKey()) {
            if let JSONData = JSONStringIn.data(using: .utf8) {
                let cachedArray = try? JSONDecoder().decode([MyPlanObject].self, from: JSONData)
                array = cachedArray ?? []
            }
        }
        var amount = 0.0
        for i in array {
            amount += i.amountSpent
        }
        return amount
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

extension UIColor {
    static let mint: UIColor = UIColor(hex: "#cfffe5ff")!
}

extension UIDevice {
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String {
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()
}

extension UIView {
    func addDropShadow(color: UIColor = .black, offset: CGSize = CGSize(width: 0, height: 2), radius: CGFloat = 2, opacity: Float = 0.3) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}

extension UIViewController {

    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            //print("User Notification settings: (settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    func requestNotificationAuthorization() {
        // Request for permissions
        UNUserNotificationCenter.current()
            .requestAuthorization(
            options: [.alert, .sound, .badge]) {
                [weak self] granted, _ in
                //print("Notification granted: (granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }

}
