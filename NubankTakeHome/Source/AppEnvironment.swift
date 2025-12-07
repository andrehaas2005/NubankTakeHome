enum AppEnvironment {
  case dev
  case stage
  case prod
  case mock
  
  var baseURL: String {
    switch self {
    case .dev:
      return "https://dev.url-shortener.com/api"
    case .stage:
      return "https://stage.url-shortener.com/api"
    case .prod:
      return "https://url-shortener-server.onrender.com/api"
    case .mock:
      return "http://localhost:3000/api"
    }
  }
}
