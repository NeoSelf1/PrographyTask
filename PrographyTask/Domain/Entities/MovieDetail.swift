import Foundation

struct MovieDetail: Identifiable {
    let id: String
    let title: String
    let overview: String
    let posterURL: URL?
    let voteAverage: Double
    let genres: [String]
    let releaseDate: String
    let userReview: String?
    let lastUpdated: Date
}
