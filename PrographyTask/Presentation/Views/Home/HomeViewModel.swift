import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var currentMovies: [Movie] = []
    
    @Published var selectedTab: Int = 0
    @Published var isFetching: Bool = false
    @Published var hasMorePages: Bool = true
    
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    
    private let movieRepository: MovieRepositoryProtocol
    
    init(
        movieRepository: MovieRepositoryProtocol = MovieRepository()
    ) {
        self.movieRepository = movieRepository
        
        initialize()
    }
    
    func initialize() {
        Task {
            do {
                let popularResponse = try await movieRepository.fetchPopular(1)
                popularMovies = popularResponse.results
                
                let nowPlayingResponse = try await movieRepository.fetchNowPlaying(1)
                currentMovies = nowPlayingResponse.results
                
                currentPage = nowPlayingResponse.page
                totalPages = nowPlayingResponse.totalPages
                
                hasMorePages = currentPage < totalPages
            } catch {
                print("error refreshing: \(error)")
            }
        }
    }
    
    func selectTab(_ tab: Int) async {
        guard !isFetching else { return }
        
        selectedTab = tab
        resetPagination()
        
        await fetchData(tab)
    }
    
    func loadMoreIfNeeded(currentItem: Movie) {
        guard let lastItem = currentMovies.last,
              currentItem.id == lastItem.id,
              hasMorePages,
              !isFetching else {
            return
        }
        
        Task {
            await loadMore()
        }
    }
    
    func loadMore() async {
        guard hasMorePages, !isFetching else { return }
        
        let nextPage = currentPage + 1
        await fetchData(selectedTab, page: nextPage, reset: false)
    }
}

extension HomeViewModel {
    private func resetPagination() {
        currentPage = 1
        totalPages = 1
        hasMorePages = true
        currentMovies = []
    }
    
    private func fetchData(_ tab: Int, page: Int = 1, reset: Bool = false) async {
        isFetching = true
        
        do {
            let response: MoviesResponse
            
            switch tab {
            case 0:
                response = try await movieRepository.fetchNowPlaying(page)
            case 1:
                response = try await movieRepository.fetchPopular(page)
            default:
                response = try await movieRepository.fetchTopRated(page)
            }
            
            if reset {
                currentMovies = response.results
            } else {
                currentMovies.append(contentsOf: response.results)
            }
            
            currentPage = response.page
            totalPages = response.totalPages
            hasMorePages = currentPage < totalPages
            
            isFetching = false
        } catch {
            isFetching = false
            print("error refreshing \(tab): \(error)")
        }
    }
}
