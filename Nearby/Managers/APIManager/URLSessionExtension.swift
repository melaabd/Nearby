//
//  URLSessionExtension.swift
//  Nearby
//
//  Created by melaabd on 1/12/22.
//

import Foundation


/// Defines network response status and provides error strings for network request error
enum NetworkResponse: String {
    case success
    case authenticationError    = "Authentication Error"
    case badRequest             = "Bad Request"
    case failed                 = "Network request Failed"
    case noData                 = "No Data Found"
    case unableToDecode         = "Decoding Error"
    case noInternet             = "No Internet Connectivity."
}

// MARK: - URLSession response handlers
extension URLSession {
    /// load weather data task
    /// - Parameters:
    ///   - url: URL
    ///   - completionHandler: (Weather?, URLResponse?, Error?)
    /// - Returns: URLSessionDataTask
    func venuesTask(with url: URL, completionHandler: @escaping (NearbyVenues?, String?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
    /// base codableTask with custom url and geniric model
    /// - Returns: URLSessionDataTask
    private func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, String?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { [weak self] data, response, error in
            
            if let _ = error {
                completionHandler(nil, NetworkResponse.noInternet.rawValue)
                return
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse else {
                completionHandler(nil, NetworkResponse.failed.rawValue)
                return
            }
            
            let networkResponse = self?.parseHTTPResponse(httpURLResponse)
            
            switch networkResponse {
            case .success:
                guard let data = data else {
                    completionHandler(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(decodedResponse, nil)
                } catch {
                    completionHandler(nil, NetworkResponse.unableToDecode.rawValue)
                }
            default:
                guard let data = data else {
                    completionHandler(nil, networkResponse?.rawValue)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(decodedResponse, nil)
                } catch {
                    completionHandler(nil, NetworkResponse.unableToDecode.rawValue)
                }
            }
            
        }
    }
        
    /// Checks URLResponse statusCode and returns a *NetworkResponse* case depending upon status
    /// - Parameter urlResponse: URLResponse received back from URLTask
    private func parseHTTPResponse(_ urlResponse:HTTPURLResponse) -> NetworkResponse {
        switch urlResponse.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .authenticationError
        case 501...600:
            return .badRequest
        default:
            return .failed
        }
    }
}
