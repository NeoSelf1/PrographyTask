import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    private let tabs = ["Now Playing", "Popular", "Top Rated"]
    
    var body: some View {
        VStack(spacing: 0) {
            CustomHeader()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    mainSection
                    movieTabView
                    listSection
                }
            }
            .navigationBarHidden(true)
            .refreshable {
                await viewModel.selectTab(viewModel.selectedTab)
            }
        }
    }
    
    private var mainSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(viewModel.popularMovies) { movie in
                    let movieId = String(movie.id)
                    
                    NavigationLink(destination: DetailView(movieId: movieId)) {
                        
                        HorizontalMovieCell(movie: movie)
                            .frame(width: 316)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
    
    private var movieTabView: some View {
        GeometryReader { geometry in
            VStack(alignment:.leading, spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(0..<3, id: \.self) { index in
                        Button(action: {
                            Task {
                                await viewModel.selectTab(index)
                            }
                        }) {
                            Text(tabs[index])
                                .font(._subtitle2)
                                .foregroundColor(viewModel.selectedTab == index ? .red50 : .gray60)
                                .frame(maxWidth: geometry.size.width / 3, maxHeight: 40, alignment: .center)
                        }
                        .animation(.mediumSpring, value: viewModel.selectedTab)
                    }
                }
                
                Rectangle()
                    .fill(.red50)
                    .frame(width: max(0, geometry.size.width / 3 - 64), height: 3)
                    .offset(x: CGFloat(viewModel.selectedTab) * (geometry.size.width / 3) + 32, y: -3)
                    .animation(.mediumSpring, value: viewModel.selectedTab)
            }
        }
        .frame(height: 48)
    }
    
    private var listSection: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.currentMovies) { movie in
                let movieId = String(movie.id)
                
                NavigationLink(destination: DetailView(movieId: movieId)) {
                    VerticalMovieCell(movie: movie)
                        .padding(.horizontal, 16)
                }
                .onAppear {
                    viewModel.loadMoreIfNeeded(currentItem: movie)
                }
            }
            
            if viewModel.isFetching {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: 64, alignment: .center)
            }
        }
    }
}

#Preview {
    HomeView()
}
