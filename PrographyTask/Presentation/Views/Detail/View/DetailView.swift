import SwiftUI
import Kingfisher

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @State private var reviewText: String = ""
    
    @FocusState private var isFocused: Bool
    
    init(movieId: String) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(movieId: movieId))
    }
    
    var body: some View {
        HeaderWithBackBtn(viewModel: viewModel)
        
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false){
                if let movieDetail = viewModel.movie {
                    thumbnail(movieDetail)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        RatingSection(rating: Int(movieDetail.voteAverage / 2), size: .big)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                        
                        detailSection(movieDetail)
                        
                        commentSection(proxy)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func thumbnail(_ movie: MovieDetail) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gradient, .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            
            KFImage(movie.posterURL)
                .placeholder {
                    ProgressView()
                        .tint(.gray00)
                }
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(maxWidth: .infinity, maxHeight: 247)
    }
    
    private func detailSection(_ movieDetail: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movieDetail.title)
                .font(._headline)
            
            Text("/\(String(format: "%.1f", movieDetail.voteAverage))")
                .font(._title1)
                .foregroundColor(.gray60)
            
            GenreSection(genreNames: movieDetail.genres)
            
            Text(movieDetail.overview)
                .font(._title2)
                .foregroundColor(.gray80)
        }
    }
    
    private func commentSection(_ proxy: ScrollViewProxy) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Comment")
                .font(._title1)
            
            if let movie = viewModel.movie, !viewModel.isWritingEnabled {
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.reviewText)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                    
                    Text(movie.lastUpdated.apiFormat)
                        .font(._body2)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                }
                .foregroundStyle(.gray90)
                .padding(.horizontal,16)
                .padding(.vertical,12)
                
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.red10)
                )
            } else {
                CustomTextField(
                    text: $viewModel.reviewText,
                    placeholder: "후기를 작성해주세요.",
                    keyboardType: .default,
                    onSubmit: viewModel.createOrEditReview
                )
                .focused($isFocused)
                .onChange(of: isFocused) { _, newValue in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                        withAnimation {
                            proxy.scrollTo("bottomMargin", anchor: .top)
                        }
                    }
                }
                
                Color.clear
                    .id("bottomMargin")
                    .contentShape(Rectangle())
                    .frame(height: 40)
            }
        }
        .padding(.bottom,4)
    }
}

#Preview {
    DetailView(movieId: "569094")
}
