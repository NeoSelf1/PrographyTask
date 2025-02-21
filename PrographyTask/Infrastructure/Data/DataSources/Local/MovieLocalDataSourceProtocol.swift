import CoreData
import Foundation

protocol MovieLocalDataSourceProtocol {
    func getAllReviewedMovies() throws -> [MovieDetail]
    func getReviewedMovie(id: String) throws -> MovieDetail?
    func saveReviewedMovie(_ movieDetail: MovieDetail, userReview: String) throws
    func deleteReviewedMovie(id: String) throws
    func getMoviesByRating(stars: Int) throws -> [MovieDetail]
}

class MovieLocalDataSource: MovieLocalDataSourceProtocol {
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }
    
    func getAllReviewedMovies() throws -> [MovieDetail] {
        let request = MovieDetailEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "lastUpdated", ascending: false)
        ]
        
        let entities = try coreDataStack.context.fetch(request)
        
        return entities.map{$0.toDomain()}
    }
    
    func getReviewedMovie(id: String) throws -> MovieDetail? {
        let request = MovieDetailEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        let entity = try coreDataStack.context.fetch(request)
        
        if let entity = entity.first {
            return entity.toDomain()
        } else {
            return nil
        }
    }
    
    func saveReviewedMovie(_ movieDetail: MovieDetail, userReview: String) throws {
        try coreDataStack.performInTransaction {
            let request = MovieDetailEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", movieDetail.id)
            
            if let existingEntity = try coreDataStack.context.fetch(request).first {
                existingEntity.userReview = userReview
                existingEntity.lastUpdated = Date()
            } else {
                let entity = MovieDetailEntity.fromDomain(movieDetail, in: coreDataStack.context)
                entity.userReview = userReview
                entity.lastUpdated = Date()
            }
        }
    }
    
    func deleteReviewedMovie(id: String) throws {
        try coreDataStack.performInTransaction {
            let request = MovieDetailEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)
            
            if let movie = try coreDataStack.context.fetch(request).first {
                coreDataStack.context.delete(movie)
            }
        }
    }
    
    func getMoviesByRating(stars: Int) throws -> [MovieDetail] {
        let request = MovieDetailEntity.fetchRequest()
        
        let minRating = Double(stars * 2)
        let maxRating = Double(stars * 2) + 2.0
        
        request.predicate = NSPredicate(
            format: "voteAverage >= %f AND voteAverage < %f",
            minRating, maxRating
        )
        
        let entities = try coreDataStack.context.fetch(request)
        return entities.map { $0.toDomain() }
    }
}
