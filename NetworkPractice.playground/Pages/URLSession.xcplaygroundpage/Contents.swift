import Foundation

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
    
    let result = String(data: data, encoding: .utf8)
    print(result ?? "")
}

task.resume()
