//
//  NetworkClient.swift
//  World Restaurants
//
//  Created by Farzad on 2/7/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol NetworkApiClient {
    var session: URLSession {get}
    func fetch<T: JSONDecodable>(with request:URLRequest, parse: @escaping (JSON) -> T?, complition: @escaping (Result<T, APIError>) -> ())
    func fetch<T: JSONDecodable>(with request:URLRequest, parse: @escaping (JSON) -> [T], complition: @escaping (Result<[T], APIError>) -> ())
    
}

extension NetworkApiClient {
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, APIError?) -> Void
    typealias DOWNLOADTaskCompletionHandler = (Data?, APIError?) -> Void
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        
        return task
    }
    
    func downloadTask(with url: URL, completionHandler completion: @escaping DOWNLOADTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: url){ data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                        completion(data, nil)
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        
        return task
    }
    
    func fetch<T: JSONDecodable>(with request:URLRequest, parse: @escaping (JSON) -> T?, complition: @escaping (Result<T, APIError>) -> ()) {
        let task = jsonTask(with: request) { (json, error) in
            performUIUpdatesOnMain {
                
          
            guard let json = json else {
                if let error = error { complition(.failure(error))
                }else {
                    complition(.failure( .invalidData))
                }
                return
            }
            if let value = parse(json) {
             complition(.success(value))
            }else {
                complition(.failure(.jsonParsingFailure))
            }
            
        }
              }
        task.resume()
    }
    
    func fetch<T: JSONDecodable>(with request:URLRequest, parse: @escaping (JSON) -> [T], complition: @escaping (Result<[T], APIError>) -> ()) {
        let task = jsonTask(with: request) { (json, error) in
            performUIUpdatesOnMain {
                
            
            guard let json = json else {
                if let error = error { complition(.failure(error))
                }else {
                    complition(.failure( .invalidData))
                }
                return
            }
            let value = parse(json)
            if !value.isEmpty {
                complition(.success(value))
            }else {
                complition(.failure(.jsonParsingFailure))
            }
            
        }
        }
        task.resume()
    }
    
    func download<T>(with url:URL, parse: @escaping (Data) -> T?, complition: @escaping (Result<T, APIError>) -> ()) {
        let task = downloadTask(with: url) { (data, error) in
            performUIUpdatesOnMain {
                if let error = error {
                        complition(.failure(error))
                }else if let value = parse(data!) {
                    
                    complition(.success(value))
                }
            }
        }
        task.resume()
    }
    
}
