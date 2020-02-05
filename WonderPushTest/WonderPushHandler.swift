//
//  WonderPushHandler.swift
//  WonderPushTest
//
//  Created by hitesh on 05/02/20.
//  Copyright © 2020 hitesh. All rights reserved.
//

import WonderPush

class WonderPushHandler {
    class func subscribe(){
        WonderPush.subscribeToNotifications()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            print("isSubscribed : \(isSubscribed)")
        }
    }
    
    class func unsubscribe(){
        WonderPush.unsubscribeFromNotifications()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            print("isSubscribed : \(isSubscribed)")
        }
    }
    
    class func setGender(_ value:String){
        WonderPush.putProperties([
          "string_gender": value,
        ])
    }
    
    class var gender : String {
        return WonderPush.getPropertyValue("string_gender") as? String ?? "<empty>"
    }
    
    class var isSubscribed : Bool {
        return WonderPush.isSubscribedToNotifications()
    }
}
