import Foundation
import SwiftUI

@MainActor
class MyPageViewModel: ObservableObject {
    @Published var movies: [MovieDetail] = []
    @Published var selectedRating: Int = 6
    @Published var isLoading = false
    
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
        
        initialize()
    }
    
    func initialize() {
        isLoading = true
        
        do {
            movies = try repository.getLocalMovies()
            
            isLoading = false
        } catch {
            isLoading = false
            print("Error fetching movie detail: \(error)")
        }
    }
    
    func filterByRating(_ rating: Int) async {
        isLoading = true
        
        do {
            if rating == 6 {
                movies = try repository.getLocalMovies()
            } else {
                movies = try repository.getLocalMovies(by: rating)
            }
            
            selectedRating = rating
        } catch {
            print("Error filtering movies: \(error)")
            movies = []
        }
    }
}
