import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get("auth", "login", use: ShowLoginFormAction().invoke)
    
    app.post("auth", "login", use: DoLoginAction().invoke)
}
