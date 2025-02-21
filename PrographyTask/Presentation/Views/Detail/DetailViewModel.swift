import Foundation
import SwiftUI

@MainActor
class DetailViewModel: ObservableObject {
    @Published var movie: MovieDetail?
    @Published var isLoading: Bool = false
    @Published var isWritingEnabled: Bool = true
    @Published var errorMessage: String?
    @Published var reviewText: String = ""
    
    private let movieId: String
    private let repository: MovieRepositoryProtocol
    
    init(movieId: String, repository: MovieRepositoryProtocol = MovieRepository()) {
        self.movieId = movieId
        self.repository = repository
        
        initialize()
    }
    
    func initialize() {
        isLoading = true
        
        Task {
            do {
                let result = try await repository.getMovieDetail(id: String(movieId))
                
                movie = result.movie
                
                if result.isLocal {
                    reviewText = result.movie.userReview ?? ""
                    isWritingEnabled = false
                }
                
                isLoading = false
            } catch {
                errorMessage = "Failed to load movie details: \(error.localizedDescription)"
                isLoading = false
                
                print("Error fetching movie detail: \(error)")
            }
        }
    }
    
    func setWritingEnabled(_ state: Bool) {
        isWritingEnabled = state
    }
    
    func createOrEditReview() {
        guard let movie = movie,
              !isLoading,
              !reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        isLoading = true
        
        do {
            try repository.createOrUpdateLocalReview(movie:movie, review: reviewText)
            try refreshMovieDetail()
            
            isWritingEnabled = false
            isLoading = false
        } catch {
            errorMessage = "리뷰 저장에 실패했습니다: \(error.localizedDescription)"
            
            isLoading = false
        }
    }
    
    func deleteReview() {
        guard let movie = movie else { return }
        
        isLoading = true
        
        do {
            try repository.deleteLocalMovieDetail(movie.id)
            try refreshMovieDetail()
            
            isLoading = false
        } catch {
            errorMessage = "리뷰 삭제에 실패했습니다: \(error.localizedDescription)"
            
            isLoading = false
        }
    }
}


extension DetailViewModel {
    private func refreshMovieDetail() throws {
        guard let movie = movie else { return }
        
        self.movie = try repository.getLocalMovie(id: movie.id)
        
        isWritingEnabled = movie.userReview == nil
    }
}
