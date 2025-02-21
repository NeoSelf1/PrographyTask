import Foundation

struct EnvironmentVar {
    var apiKey: String {
        getEnvironmentVariable("TMDB_API_KEY")
    }
    
    private func getEnvironmentVariable(_ name: String) -> String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: name) as? String else {
            fatalError("no api key found")
        }
        return apiKey
    }
}
