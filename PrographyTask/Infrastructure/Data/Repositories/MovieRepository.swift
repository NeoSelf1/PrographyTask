

final class MovieRepository: MovieRepositoryProtocol {
    private let remoteDataSource: MovieRemoteDataSourceProtocol
    private let localDataSource: MovieLocalDataSourceProtocol
    
    init(
        remoteDataSource: MovieRemoteDataSourceProtocol = MovieRemoteDataSource(),
        localDataSource: MovieLocalDataSourceProtocol = MovieLocalDataSource()
        
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getMovieDetail(id: String) async throws -> (movie:MovieDetail, isLocal: Bool) {
        if let localMovieDetail = try localDataSource.getReviewedMovie(id: id) {
            return (localMovieDetail, true)
        }
        
        let remoteMovieDetail = try await remoteDataSource.fetchMovieDetail(id: id)
            .toDomain()
        
        return (remoteMovieDetail, false)
    }
    
    func getLocalMovies(by rating: Int) throws -> [MovieDetail] {
        return try localDataSource.getMoviesByRating(stars: rating)
    }
    
    func getLocalMovies() throws -> [MovieDetail] {
        return try localDataSource.getAllReviewedMovies()
    }
    
    func getLocalMovie(id: String) throws -> MovieDetail? {
        return try localDataSource.getReviewedMovie(id: id)
    }
    
    func fetchPopular(_ page:Int = 1) async throws -> MoviesResponse {
        return try await remoteDataSource.fetchPopular(page)
    }
    
    func fetchTopRated(_ page:Int = 1) async throws -> MoviesResponse {
        return try await remoteDataSource.fetchTopRated(page)
    }
    
    func fetchNowPlaying(_ page:Int = 1) async throws -> MoviesResponse {
        return try await remoteDataSource.fetchNowPlaying(page)
    }
    
    func createOrUpdateLocalReview(movie: MovieDetail, review: String) throws {
        try localDataSource.saveReviewedMovie(movie, userReview: review)
    }
    
    func deleteLocalMovieDetail(_ id: String) throws {
        try localDataSource.deleteReviewedMovie(id: id)
    }
}
