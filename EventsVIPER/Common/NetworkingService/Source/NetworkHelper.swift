//
//  Copyright © 2019 Mohamed Waly. All rights reserved.
//

import Foundation

enum DefaultValues: String {
    case apiKey = "6752511f3291b2b182ee4d2ef312"
}

enum Result<T> {
    case success(value: T)
    case failure(error: Error)
}

enum Path: String {
    case findEvents = "find/events"
    case baseURL = "https://api.meetup.com/"
}

enum NetworkError: Error {
    case generic
    case parsing
    case unknown
}

enum NetworkRequestParameters: String {
    case apiKey = "key"
    case text
    case lon
    case lat
}

