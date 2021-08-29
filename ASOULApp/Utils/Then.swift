//

//
//  Then.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/27.
//  
//
    

import UIKit

protocol Then {}

extension Then where Self: Any {
    func then(_ block: (inout Self) -> ()) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}

extension Then where Self: AnyObject {
    func then(_ block: (Self) -> ()) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}
