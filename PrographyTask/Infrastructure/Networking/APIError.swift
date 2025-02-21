import Foundation

/// API 호출 시 발생할 수 있는 에러 타입들을 정의하는 파일입니다.
/// URLSession의 에러를 앱 내부에서 사용하는 에러 타입으로 매핑합니다.
enum APIError: Error, Equatable {
    case invalidURL
    case decodingError
    
    case unauthorized
    case notFound
    
    case networkError
    case serverError(String)
    case unknown
    
    init(error: Error) {
        switch error {
        case let urlError as URLError:
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                self = .networkError
            case .badURL, .unsupportedURL:
                self = .invalidURL
            default:
                self = .unknown
            }
            
        case let apiError as APIError:
            self = apiError
            
        case is DecodingError:
            self = .decodingError
            
        default:
            self = .unknown
        }
    }
    
    init(statusCode: Int) {
        switch statusCode {
        case 401:
            self = .unauthorized
        case 404:
            self = .notFound
        case 500...599:
            self = .serverError("Server error: \(statusCode)")
        default:
            self = .networkError
        }
    }
}
