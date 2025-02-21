import SwiftUI
import Kingfisher

struct HorizontalMovieCell: View {
    let movie: Movie
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            KFImage(ImageEndpoint.pathToURL(path: movie.backdropPath ?? "", size: .w500))
                .placeholder {
                    Rectangle()
                        .fill(.gray60)
                        .overlay(
                            ProgressView()
                                .tint(.gray00)
                        )
                }
                .fade(duration: 0.25)
                .aspectRatio(contentMode: .fill)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.8), .clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 205)
                )
                .frame(width: 316, height: 205)
                .cornerRadius(28)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(._title1)
                    .foregroundColor(.gray00)
                
                Text(movie.overview)
                    .font(._body1)
                    .foregroundColor(.gray00)
                    .lineLimit(1)
            }
            .padding(16)
        }
    }
}
