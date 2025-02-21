import SwiftUI

struct GenreSection: View {
    let genreNames: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(genreNames, id: \.self) { genre in
                    Text(genre)
                        .font(._body1)
                        .foregroundColor(.gray60)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.gray00)
                                .stroke(.red50, lineWidth: 1)
                                .padding(1)
                        )
                }
            }
        }
    }
}
