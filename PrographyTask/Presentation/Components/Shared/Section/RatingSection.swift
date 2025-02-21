import SwiftUI

enum RatingSectionSize {
    case small
    case big
    
    var starSize: CGFloat {
        switch self {
        case .small: return 16
        case .big: return 40
        }
    }
    
    var spacing: CGFloat {
        switch self {
        case .small: return 4
        case .big: return 0
        }
    }
}

struct RatingSection: View {
    let rating: Int
    let size: RatingSectionSize
    
    var body: some View {
        HStack(alignment: .center, spacing: size.spacing) {
            ForEach(1...5, id: \.self) { index in
                Image("star")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: size.starSize, height: size.starSize)
                    .foregroundStyle(index <= rating ? .red50 : .gray40)
            }
        }
    }
}
