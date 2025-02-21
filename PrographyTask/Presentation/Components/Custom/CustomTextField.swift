import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    var onSubmit: (() -> Void)?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .foregroundColor(.gray90)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.gray00)
                        .stroke(.red50, lineWidth: 1)
                        .padding(1)
                )
                .onSubmit {
                    onSubmit?()
                }
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray40)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 16)
            }
        }
        .frame(height: 80, alignment: .topLeading)
    }
}
