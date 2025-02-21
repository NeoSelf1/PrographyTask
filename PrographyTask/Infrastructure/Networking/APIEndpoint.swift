import Foundation

enum APIEndpoint {
    case nowPlaying(Int)
    case popular(Int)
    case topRated(Int)
    case movieDetail(String)
    
    var path: String {
        switch self {
        case .nowPlaying(let page):
            return "/movie/now_playing?page=\(page)"
        case .popular(let page):
            return "/movie/popular?page=\(page)"
        case .topRated(let page):
            return "/movie/top_rated?page=\(page)"
            
        case .movieDetail(let movieId):
            return "/movie/\(movieId)"
        }
    }
}

/// 이미지 크기 옵션
enum ImageSize: String {
    case original = "original"
    case w500 = "w500"
    case w300 = "w300"
}

/// TMDB 이미지 URL을 생성하기 위한 유틸리티 열거형
enum ImageEndpoint {
    /// 포스터 이미지 URL 생성
    /// - Parameters:
    ///   - path: 이미지 경로
    ///   - size: 이미지 크기 (기본값: .original)
    /// - Returns: 완성된 이미지 URL
    static func pathToURL(path: String, size: ImageSize) -> URL? {
        guard !path.isEmpty else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/\(size)/\(path)")
    }
}
