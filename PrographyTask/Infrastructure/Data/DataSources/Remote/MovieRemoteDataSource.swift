protocol MovieRemoteDataSourceProtocol {
    func fetchNowPlaying(_ page: Int) async throws -> MoviesResponse
    func fetchPopular(_ page: Int) async throws -> MoviesResponse
    func fetchTopRated(_ page: Int) async throws -> MoviesResponse
    func fetchMovieDetail(id: String) async throws -> MovieDetailDTO
}

class MovieRemoteDataSource: MovieRemoteDataSourceProtocol {
    private let networkAPI: NetworkAPI
    
    init(networkAPI: NetworkAPI = NetworkAPI()) {
        self.networkAPI = networkAPI
    }
    
    func fetchNowPlaying(_ page: Int = 1) async throws -> MoviesResponse {
        return try await networkAPI.request(.nowPlaying(page), method: .get, parameters: nil)
    }
    
    func fetchPopular(_ page: Int = 1) async throws -> MoviesResponse {
        return try await networkAPI.request(.popular(page), method: .get, parameters: nil)
    }
    
    func fetchTopRated(_ page: Int = 1) async throws -> MoviesResponse {
        return try await networkAPI.request(.topRated(page), method: .get, parameters: nil)
    }
    
    func fetchMovieDetail(id: String) async throws -> MovieDetailDTO {
        return try await networkAPI.request(.movieDetail(id), method: .get, parameters: nil)
    }
}
