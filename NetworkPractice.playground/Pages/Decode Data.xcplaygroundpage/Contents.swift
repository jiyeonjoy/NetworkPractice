import Foundation

struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int
    let following: Int
    
//    enum CodingKeys: String, CodingKey {
//        case login
//        case avatarUrl = "avatar_url"
//        case htmlUrl = "html_url"
//        case followers
//        case following
//    }
}

let configuration = URLSessionConfiguration.default
let session = URLSession(configuration: configuration)

let url = URL(string: "https://api.github.com/users/jiyeonjoy")!

let task = session.dataTask(with: url) { data, response, error in
    guard let httpResponse = response as? HTTPURLResponse,
          (200..<300).contains(httpResponse.statusCode) else {
        print("---> response: \(String(describing: response))")
        return
    }

    guard let data = data else {
        return
    }
    
//    let result = String(data: data, encoding: .utf8)
//    print(result ?? "")
    
    do {
        let decoder = JSONDecoder()
        // CodingKeys 대신 이렇게 쓸 수 있음!!!!
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let profile = try decoder.decode(GithubProfile.self, from: data)
        print("profile: \(profile)")
    } catch let error as NSError {
        print("error: \(error)")
    }
}

task.resume()
