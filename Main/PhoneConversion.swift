//
//  PhoneConversion.swift
//  Main
//
//  Created by Garvin Casinillo on 3/22/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import Foundation


extension String {
    public mutating func toPhoneNumber() -> String {
        self.remove(at: self.startIndex)
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "1 - ($1) - $2 - $3", options: .regularExpression, range: nil)
    }
    
    
    public mutating func toFormattedPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
    
    
    public func toNumberString() -> String {
        let stringArray = self.components(separatedBy:NSCharacterSet.decimalDigits.inverted)
        let pureNumber = stringArray.joined(separator: "")
        return pureNumber
    }
    

    
}



