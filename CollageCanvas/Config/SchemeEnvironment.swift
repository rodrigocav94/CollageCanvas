//
//  SchemeEnvironment.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import Foundation

extension SchemeEnvironment {
    enum Variable: String {
        case pexelsKey = "PEXELS_KEY"
    }
}

struct SchemeEnvironment {
    static func getValue(forKey key: Variable) -> String {
        return infoForKey(key.rawValue)
    }
    
    private static func infoForKey(_ key: String) -> String {
        guard let value = (Bundle.main.infoDictionary?[key] as? String) else {
            fatalError("Could not get value for key: \(key)")
        }
        return value.replacingOccurrences(of: "\\", with: "")
    }
}
