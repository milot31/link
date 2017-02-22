//
//  UserDefaults.swift
//  Link
//
//  Created by Phil Milot on 2/21/17.
//  Copyright © 2017 Phil Milot. All rights reserved.
//

import Foundation

class UserDefaults {
    
    private class var standardUserDefaults: Foundation.UserDefaults {
        return Foundation.UserDefaults.standard
    }
    
    fileprivate class var kUserNameForSMS: String {
        return "UserNameForSMS"
    }
    
    class func getUserNameForSMS() -> String? {
        return standardUserDefaults.object(forKey: kUserNameForSMS) as? String
    }
    
    class func setUserNameForSMS(_ name: String) {
        return standardUserDefaults.set(name, forKey: kUserNameForSMS)
    }
}
