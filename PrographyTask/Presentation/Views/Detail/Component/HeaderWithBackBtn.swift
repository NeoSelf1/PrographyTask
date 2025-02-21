import SwiftUI

struct HeaderWithBackBtn: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 24))
                    .foregroundColor(.gray90)
            }
            
            Spacer()
            
            Image("prography")
                .font(._headline)
                .foregroundColor(.red50)
            
            Spacer()
            
            if viewModel.isWritingEnabled {
                Button(action: viewModel.createOrEditReview){
                    Text("저장")
                        .font(._title2)
                        .foregroundStyle(.blue50)
                }
                .disabled(viewModel.reviewText.isEmpty)
            } else {
                Menu {
                    Button(action: {
                        viewModel.setWritingEnabled(true)
                    }) {
                        Text("수정하기")
                    }
                    
                    Button(role: .destructive, action: {
                        viewModel.deleteReview()
                        dismiss()
                    }) {
                        Text("삭제하기")
                    }
                } label: {
                    Image("more")
                        .font(.system(size: 28))
                }
                
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: 56, alignment: .center)
    }
}
