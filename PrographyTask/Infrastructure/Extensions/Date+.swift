import Foundation

extension Date {
    private static let koreanTimeZone = TimeZone(identifier: "Asia/Seoul")!
    
    private static let sharedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = koreanTimeZone
        return formatter
    }()
    
    private func string(withFormat format: String) -> String {
        let formatter = Date.sharedFormatter
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var apiFormat: String {
        string(withFormat: "yyyy-MM-dd")
    }
}
