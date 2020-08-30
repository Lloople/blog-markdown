import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    let auth = app.grouped("auth").grouped(User.authenticator())
    
    auth.get("login", use: ShowLoginFormAction().invoke)
    
    auth.post("login", use: DoLoginAction().invoke)
    
    
}
