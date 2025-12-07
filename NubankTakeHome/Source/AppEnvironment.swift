enum AppEnvironment {
  case dev
  case stage
  case prod
  case mock
  
  var baseURL: String {
    switch self {
    case .dev:
       "https://dev.url-shortener.com/api"
    case .stage:
       "https://stage.url-shortener.com/api"
    case .prod:
       "https://url-shortener-server.onrender.com"
    case .mock:
       "http://localhost:3000/api"
    }
  }
}
