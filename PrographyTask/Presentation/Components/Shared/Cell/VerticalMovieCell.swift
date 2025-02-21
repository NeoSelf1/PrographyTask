import SwiftUI
import Kingfisher

struct VerticalMovieCell: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 16) {
            KFImage(ImageEndpoint.pathToURL(path: movie.posterPath ?? "", size: .w300))
                .placeholder {
                    Rectangle()
                        .fill(.gray80)
                        .overlay(
                            ProgressView()
                                .tint(.gray00)
                        )
                }
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 160)
                .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(._subhead)
                    .foregroundColor(.gray80)
                    .lineLimit(1)
                
                Text(movie.overview)
                    .font(._title2)
                    .foregroundColor(.gray60)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Text("rate: \(movie.formattedRating)")
                    .font(._subtitle1)
                    .foregroundColor(.gray60)
                
                GenreSection(genreNames: movie.genreNames)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
   
}
