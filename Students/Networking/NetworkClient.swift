//
//  NetworkClient.swift
//  Students
//
//  Created by Ilgar Ilyasov on 9/19/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

struct NetworkClient {
    
    static let url = URL(string: "https://studentdirectory.vapor.cloud/students")!
    
    func fethcData(completion: @escaping ([Student]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: NetworkClient.url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil,error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(nil, NSError())
                return
            }
            
            do {
                let students = try JSONDecoder().decode([Student].self, from: data)
                completion(students, nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
        
    }
}
