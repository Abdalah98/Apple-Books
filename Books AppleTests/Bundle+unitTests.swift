//
//  Bundle+unitTests.swift
//  Books Apple
//
//  Created by Abdallah on 12/8/21.
//

import Foundation
extension Bundle {
    public class var unitTest: Bundle {
        return Bundle(for: APIServiceTests.self)
    }
}

