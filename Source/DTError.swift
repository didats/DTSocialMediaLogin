//
//  DTError.swift
//  Tester
//
//  Created by Didats Triadi on 04/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import Foundation

protocol DTErrorProtocol: LocalizedError  {
    var title: String? { get }
    var code: Int { get }
}

public struct DTError: DTErrorProtocol {
    var title: String?
    var code:  Int
    public var errorDescription: String? { return _description }
    public var failureReason: String?  { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title
        self._description = description
        self.code = code
    }
}
