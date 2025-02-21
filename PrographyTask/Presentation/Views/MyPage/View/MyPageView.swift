import SwiftUI
import Kingfisher

struct MyPageView: View {
    @StateObject var viewModel = MyPageViewModel()
    @State private var showRatingMenu = false
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 0) {
            CustomHeader()
                .padding(.bottom, 16)
            
            RatingDropdownButton(
                selectedRating: viewModel.selectedRating,
                onTap: { showRatingMenu.toggle() }
            )
            .padding(.horizontal)
            
            
            ZStack {
                if viewModel.movies.isEmpty {
                    Text("리뷰를 작성한 영화가 없어요")
                        .font(._title2)
                        .foregroundColor(.gray60)
                        .frame(maxHeight: .infinity,alignment: .center)
                    
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                            ForEach(viewModel.movies) { movie in
                                NavigationLink(destination: DetailView(movieId: movie.id)) {
                                    MovieGridCell(movie: movie)
                                }
                            }
                        }
                    }
                    .padding(.top, 16)
                }
                
                if showRatingMenu {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture { showRatingMenu = false }
                    
                    VStack {
                        RatingDropdownMenu(
                            selectedRating: viewModel.selectedRating,
                            onSelect: { rating in
                                Task {
                                    await viewModel.filterByRating(rating)
                                }
                                
                                showRatingMenu = false
                            }
                        )
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                }
            }
        }
        .onAppear{viewModel.initialize()}
        .navigationBarHidden(true)
    }
}

#Preview {
    MyPageView()
}
