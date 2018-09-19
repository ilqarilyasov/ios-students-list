//
//  Student.swift
//  Students
//
//  Created by Ilgar Ilyasov on 9/19/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

struct Student: Codable {
    var name: String
    
    var firstName: String {
        return String(name.split(separator: " ")[0])
    }
    
    var LastName: String? {
        guard let last = name.split(separator: " ").dropFirst().last else { return nil }
        return String(last)
    }
}
