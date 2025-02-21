import SwiftUI

/// 앱의 메인 탭 기반 네비게이션 구조를 구현하는 뷰입니다.
struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                switch(selectedTab) {
                case 0:
                    HomeView()
                default:
                    MyPageView()
                }
                
                bottomTab
            }
        }
    }
    
    @ViewBuilder
    private var bottomTab: some View {
        let tabBarText = [("home","HOME"), ("star","MY")]
        
        ZStack {
            Rectangle()
                .fill(.gray10)
                .frame(height: 72)
            
            HStack(alignment: .center, spacing: 0) {
                ForEach(0..<2, id: \.self) { index in
                    Button(action:{
                        print(index)
                        withAnimation(.fastEaseInOut) { selectedTab = index }
                    } ) {
                        VStack(spacing: 4) {
                            Image(tabBarText[index].0)
                                .renderingMode(.template)
                                .foregroundColor(selectedTab == index ? .red50 : .gray90)
                            
                            Text(tabBarText[index].1)
                                .font(._body1)
                                .foregroundColor(selectedTab == index ? .red50 : .gray90)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                
            }
            .frame(height: 72)
            .background(.gray10)
        }
    }
}

#Preview {
    MainTabView()
}
