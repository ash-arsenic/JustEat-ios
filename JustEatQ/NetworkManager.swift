//
//  NetworkManager.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 07/03/23.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    /// func for request for api
    func requestForApi(url: String, completionHandler: ((Any)->())?) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) {data, response, err in
            if let err = err {
                print("Received some error in api \(err.localizedDescription)")
                return
            }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else {
                print("Getting some error on json Sericliaxation")
                return
            }
            completionHandler?(jsonData)
        }.resume()
    }
}
