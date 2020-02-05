//
//  AppEnums.swift
//  WonderPushTest
//
//  Created by hitesh on 05/02/20.
//  Copyright © 2020 hitesh. All rights reserved.
//

import UIKit

enum Storyboards : String {
    case Main
}

enum Controllers : String {
    case HomeVC
}

extension UIImage {
    static let selectionImage = UIImage(named: "blue-tick")!
}

enum WonderPushCredentials : String {
    case clientId = "7b61b48bdaf2bc40da311b96812e3a833c9ee48d"
    case clientSecret = "08fd5728caa4df728e2deff50bf01466224326f7015c26c7df7ce917523eb305"
}

enum NotificationNames {
    static let RegisterNotification = NSNotification.Name(rawValue: "RegisterNotification")
}
