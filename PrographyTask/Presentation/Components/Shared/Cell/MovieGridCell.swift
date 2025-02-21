import SwiftUI
import Kingfisher

struct MovieGridCell: View {
    let movie: MovieDetail
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            KFImage(movie.posterURL)
                .placeholder {
                    Rectangle()
                        .fill(.gray60)
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
                .padding(.bottom,4)
            
            Text(movie.title)
                .font(._subtitle2)
                .foregroundColor(.gray90)
                .lineLimit(2)
            
            RatingSection(rating: Int(movie.voteAverage/2), size: .small)
        }
    }
}
