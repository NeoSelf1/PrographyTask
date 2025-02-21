import SwiftUI

struct RatingDropdownMenu: View {
    @State private var isAnimating = false
    
    let selectedRating: Int
    let onSelect: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach((0...6).reversed(), id: \.self) { rating in
                HStack {
                    ratingItem(for: rating)
                    
                    Spacer()
                    
                    if selectedRating == rating {
                        Image(systemName: "checkmark")
                            .foregroundColor(.red50)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                
                .contentShape(Rectangle())
                .onTapGesture { onSelect(rating) }
            }
        }
        .padding(.vertical, 8)
        
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray00)
                .stroke(.red50, lineWidth: 1)
        )
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : -64)
        .animation(.mediumEaseInOut, value: isAnimating)
        
        .onAppear {
            withAnimation { isAnimating = true }
        }
    }
}

struct RatingDropdownButton: View {
    let selectedRating: Int
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                ratingItem(for: selectedRating)
                
                Spacer()
                
                Image("menu")
            }
            .padding(.horizontal, 16)
            .foregroundColor(.gray90)
        }
        .frame(maxWidth: .infinity, maxHeight: 64, alignment: .leading)
        .background (
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray00)
                .stroke(.red50, lineWidth: 1)
        )
    }
}

@ViewBuilder
private func ratingItem(for rating: Int) -> some View{
    switch rating {
    case 6:
        Text("All")
            .font(._title1)
            .foregroundColor(.gray90)
        
    default:
        RatingSection(rating: rating, size: .big)
    }
}
