# FetchSwift


### Usage

```swift
final class SomewhereAPI: Fetch {
    var domain: String = "https://www.somewhere.com/"

    var decoder: JSONDecoder = JSONDecoder()

    var encoder: JSONEncoder = JSONEncoder()

    static let shared = SomewhereAPI()

    func willSend(params: [String: Any], method: FetchSwift.Method, path: String, parameters: [String: Any]) -> Params {
        return params
    }

    func willSend(request: URLRequest, method: FetchSwift.Method, path: String, parameters: [String: Any]) -> URLRequest {
        return request
    }

    func show(progress: Float?) {}

    func hide(progress: Float?) {}
}

extension SomewhereAPI {
    struct Post: Codeable {
        var title:String?
        var content:String?
    }

    func fetch() -> Response<[Posts]> {
        self.call(path: "posts")
    }
}
```
