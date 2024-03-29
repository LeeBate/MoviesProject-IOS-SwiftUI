//
//  NetworkManager.swift
//  ProjectMovies
//
//  Created by suranaree09 on 11/5/2565 BE.
//

import Foundation
import Alamofire

final class NetworkManager<T: Codable> {
    static func fetch(from urlString:String, completion: @escaping (Result<T, NetworkError>) -> Void){
        AF.request(urlString).responseDecodable(of: T.self){(resp) in
            if resp.error != nil {
                completion(.failure(.invalidResponse))
                print(resp.error!)
                return
            }
            
            if let payload = resp.value{
                completion(.success(payload))
                return
            }
            
            completion(.failure(.nilResponse))
        }
    }
}

enum NetworkError: Error {
    case invalidResponse
    case nilResponse
}
