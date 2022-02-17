//
//  EdmundsClient.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/2022.
//

import Foundation

struct EdmundsClient {
    func request<T: Decodable>(requestType: Client, type: T.Type,
                               completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: requestType.url) else {
            completionHandler(.failure(HTTPClientError.badURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = requestType.method.rawValue
        request.allHTTPHeaderFields = requestType.headers
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        if let parameters = requestType.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                completionHandler(.failure(error))
                return
            }
        }

        log.info("API Called: \(url)")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            if let data = data {
                do {
                    completionHandler(.success(try JSONDecoder().decode(type, from: data)))
                } catch {
                    // adding mock data temp
                    if (response as? HTTPURLResponse)?.statusCode == 503 {
                        let mockClient = MockEdmundsClient()
                        switch requestType {
                        case .makes:
                            mockClient.getMakeList { data in
                            // swiftlint:disable force_cast
                            completionHandler(.success(data as! T))
                            }
                        case .models:
                            mockClient.getModelList { data in
                            // swiftlint:disable force_cast
                            completionHandler(.success(data as! T))
                            }
                        case .style:
                            mockClient.getModelStyle { data in
                            // swiftlint:disable force_cast
                            completionHandler(.success(data as! T))
                            }
                        }
                    } else {
                        completionHandler(.failure(error))
                    }
                    return
                }
            }
        })
        dataTask.resume()
    }
}

/// HTTP Methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

/// HTTPClient Errors
enum HTTPClientError: Error {
    case badURL
}

extension HTTPClient {
    /// The URL of the receiver.
    var url: String {
        return host + path + endpoint
    }
}

/// The protocol used to define the specifications necessary for a `HTTPClient`.
protocol HTTPClient {
    /// The host, conforming to RFC 1808.
    var host: String { get }

    /// The path, conforming to RFC 1808
    var path: String { get }

    /// API Endpoint
    var endpoint: String { get }

    /// The HTTP method used in the request.
    var method: HTTPMethod { get }

    /// The HTTP request parameters.
    var parameters: [String: Any]? { get }

    /// A dictionary containing all the HTTP header fields
    var headers: [String: String]? { get }
}

enum Client {
    case makes
    case models(year: Int, makeNiceName: String)
    case style(makeNiceName: String, niceName: String)
}

extension Client: HTTPClient {
    var host: String {
        return Constants.baseURL
    }

    var path: String {
        return "/api/vehicle/v3/"
    }

    var endpoint: String {
        var customEndPoint = ""
        switch self {
        case .makes:
            customEndPoint = "makes?"
        case .models(let year, let makeNiceName):
                customEndPoint = "models?" + "makeNiceName=\(makeNiceName)&" + "modelYears.year=\(year)&"
        case .style(let makeNiceName, let niceName):
                customEndPoint = "styles?" + "makeNiceName=\(makeNiceName)&" + "modelNiceName=\(niceName)&"
        }
        return customEndPoint + "api_key=\(Constants.appApiKey)"
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: [String: Any]? {
        return nil
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
