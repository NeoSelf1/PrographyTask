import Foundation
import SwiftUI

extension Font {
    static let _headline = Font.custom("Pretendard-Bold", size: 45)
    
    static let _subhead = Font.custom("Pretendard-Bold", size: 22)
    
    static let _title1 = Font.custom("Pretendard-Bold", size: 16)
    static let _title2 = Font.custom("Pretendard-Medium", size: 16)
    
    static let _subtitle1 = Font.custom("Pretendard-SemiBold", size: 14)
    static let _subtitle2 = Font.custom("Pretendard-Bold", size: 14)
    
    static let _body1 = Font.custom("Pretendard-SemiBold", size: 11)
    static let _body2 = Font.custom("Pretendard-Regular", size: 11)
    
    // lineSpacing 값을 반환하는 연산 프로퍼티
    var lineSpacing: CGFloat {
        switch self {
        case ._headline:
            return 52 - 45  // 52
        case ._subhead:
            return 28 - 22  // 28
        case ._title1, ._title2:
            return 24 - 16  // 24
        case ._subtitle1, ._subtitle2:
            return 20 - 14  // 20
        case ._body1, ._body2:
            return 16 - 11  // 16
        default:
            return 0
        }
    }
}
