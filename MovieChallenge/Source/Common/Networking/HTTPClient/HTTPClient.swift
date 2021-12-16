//
//  HTTPClient.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum ContentType: String {
    case json = "application/json"
    case formURLEncoded = "application/x-www-form-urlencoded"
}

public enum StatusCode: Int {
    case ok = 200
    case created = 201
    case accepted = 202
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
}

public enum HTTPClientError: Error {
    case encoding
    case decoding
    case httpError(StatusCode)
    case unknown(String)
}

public struct HTTPClientConfiguration {
    
    public let baseURL: String
    public let apiKey: String
    
    public init(baseURL: String, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
}

open class HTTPClient {
    
    private let baseURL: String
    private let apiKey: String
    
    private var urlSession: URLSession {
        URLSession.shared
    }
    
    public init(configuration: HTTPClientConfiguration) {
        baseURL = configuration.baseURL
        apiKey = configuration.apiKey
    }
    
    /// This method is inteded to use the await/async approach for swift concurrency
    @available(iOS 15.0.0, *)
    public func asyncRequest<T: Codable>(resource: Resource,
                                      body: [String: AnyObject]? = nil,
                                      headers: [String: AnyObject]? = nil,
                                      type: T.Type) async throws -> T {
        
        let data: T = try await withCheckedThrowingContinuation({ continuation in
            request(resource: resource, body: body, headers: headers, type: type, completion: { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                    break
                case .failure(let error):
                    continuation.resume(throwing: error)
                    break
                }
            })
        })
        
        return data
    }
    
    public func request<T: Codable>(resource: Resource,
                                      body: [String: AnyObject]? = nil,
                                      headers: [String: AnyObject]? = nil,
                                      type: T.Type,
                                      completion: @escaping (Result<T, HTTPClientError>) -> Void) {
        
        let url = baseURL + resource.resource.route + "&api_key=\(apiKey)"
        
        #if DEBUG
        print("HTTP request: \(resource.resource.method.rawValue) \(url)")
        #endif
        
        let requestURL = URL(string: url)
        
        var request = URLRequest(url: requestURL!, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = resource.resource.method.rawValue
        request.setValue(resource.resource.contentType?.rawValue, forHTTPHeaderField: "Content-Type")
        
        if let body = body,
            resource.resource.method == .post || resource.resource.method == .put {
            
            switch resource.resource.contentType {
            case .json:
                do {
                    let httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
                    request.httpBody = httpBody
                } catch {
                    completion(.failure(.encoding))
                }
                
            case .formURLEncoded:
                let query = body.map { "\($0)=\($1)" }.joined(separator: "&")
                request.httpBody = query.data(using: .utf8)
            default:
                break
            }
        }
        
        let task = urlSession.dataTask(with: request, completionHandler: { data, response, error in

            if let response = response as? HTTPURLResponse {
                
                #if DEBUG
                print("HTTP statusCode: \(response.statusCode)")
                #endif

                if 400..<403 ~= response.statusCode {
                    if let data = data {
                        do {
                            let decodedResponse = try JSONDecoder().decode(type, from: data)
                            completion(.success(decodedResponse))
                        } catch {
                            let statusCode = StatusCode(rawValue: response.statusCode)!
                            
                            completion(.failure(.httpError(statusCode)))
                        }
                    } else {
                        // TODO: handle this
                    }
                }

                if 200..<300 ~= response.statusCode, let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(type, from: data)
                        completion(.success(decodedResponse))
                    } catch {
                        switch error {
                        case let DecodingError.dataCorrupted(context):
                            print("Data corrupted: \(context.debugDescription)")
                        case let DecodingError.keyNotFound(key, context):
                            print("Key not found: \(key), \(context.debugDescription), \(context.codingPath)")
                        case let DecodingError.valueNotFound(value, context):
                            print("Value not found: \(value), \(context.debugDescription), \(context.codingPath)")
                        case let DecodingError.typeMismatch(type, context):
                            print("Type mismatch: \(type), \(context.debugDescription), \(context.codingPath)")
                        default:
                            print(error.localizedDescription)
                            break
                        }
                        
                        completion(.failure(.decoding))
                    }
                }
            }

            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
            }
        })

        task.resume()
    }
}
