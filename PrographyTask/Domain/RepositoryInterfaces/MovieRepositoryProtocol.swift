protocol MovieRepositoryProtocol {
    func getLocalMovies(by rating: Int) throws -> [MovieDetail]
    func getLocalMovies() throws -> [MovieDetail]
    func getLocalMovie(id: String) throws -> MovieDetail?
    func createOrUpdateLocalReview(movie: MovieDetail, review: String) throws
    func deleteLocalMovieDetail(_ id: String) throws
    
    func getMovieDetail(id: String) async throws -> (movie:MovieDetail, isLocal: Bool)
    
    func fetchPopular(_ page: Int) async throws -> MoviesResponse
    func fetchTopRated(_ page: Int) async throws -> MoviesResponse
    func fetchNowPlaying(_ page: Int) async throws -> MoviesResponse
}
