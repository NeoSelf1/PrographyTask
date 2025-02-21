import CoreData
import Foundation

extension MovieDetailEntity {
    func toDomain() -> MovieDetail {
        return MovieDetail(
            id: id ?? "",
            title: title ?? "",
            overview: overview ?? "",
            posterURL: ImageEndpoint.pathToURL(path: posterPath ?? "",size: .w500),
            voteAverage: voteAverage,
            genres: (genres ?? []) ,
            releaseDate: releaseDate ?? "",
            userReview: userReview,
            lastUpdated: lastUpdated ?? Date()
        )
    }
    
    static func fromDomain(_ domain: MovieDetail, in context: NSManagedObjectContext) -> MovieDetailEntity {
        let entity = MovieDetailEntity(context: context)
        entity.id = domain.id
        entity.title = domain.title
        entity.overview = domain.overview
        entity.posterPath = domain.posterURL?.absoluteString.components(separatedBy: "/").last
        entity.voteAverage = domain.voteAverage
        entity.releaseDate = domain.releaseDate
        entity.userReview = domain.userReview
        entity.lastUpdated = domain.lastUpdated
        entity.genres = domain.genres
        
        return entity
    }
}
