//
//  Utility.swift
//  WonderPushTest
//
//  Created by hitesh on 05/02/20.
//  Copyright © 2020 hitesh. All rights reserved.
//

import UIKit
import WonderPush

class Utility {
    
    class func grabStoryboard(_ name:Storyboards) -> UIStoryboard {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        return storyboard
    }
    
    class func instantiateController(name:Controllers, storyboard:Storyboards) -> UIViewController {
        let vc = grabStoryboard(storyboard).instantiateViewController(withIdentifier: name.rawValue)
        return vc
    }
}
