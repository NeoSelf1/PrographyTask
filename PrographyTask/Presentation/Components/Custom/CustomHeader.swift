import SwiftUI

struct CustomHeader: View {
    var body: some View {
        HStack {
            Image("prography")
                .font(._headline)
                .foregroundColor(.red50)
        }
        .frame(maxWidth: .infinity, maxHeight:56, alignment: .center)
    }
}
