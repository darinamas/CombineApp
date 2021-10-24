//
//  NetworkService.swift
//  CombineApp
//
//  Created by Darinka on 24.10.2021.
//

import Foundation
import Combine

class NetworkService {
    
    func getData() -> AnyPublisher<[WPPost], NetworkError> {
        let url = URL(string: "https://finex.cz/wp-json/wp/v2/posts")
        
        return URLSession.shared.dataTaskPublisher(for: url!)
            .tryMap { response -> Data in
                guard let urlResponse = response.response as? HTTPURLResponse,
                      urlResponse.statusCode == 200
                else { throw NetworkError.apiError }  // otlavlivajem error
                return response.data
            }
            .decode(type: [WPPost].self, decoder: JSONDecoder())
            .mapError { _ in NetworkError.apiError}
            .eraseToAnyPublisher()
        
    }
}


enum NetworkError: Error {
    case apiError
}
