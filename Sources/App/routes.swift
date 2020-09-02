import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    try authRoutes(app)
    
    try adminRoutes(app)
    
}

func authRoutes(_ app: Application) throws {
    app.get("login", use: ShowLoginFormAction().invoke)
    
    app.post("login", use: DoLoginAction().invoke)
}

func adminRoutes(_ app: Application) throws {
    
    let protected = app.grouped("admin").grouped([User.sessionAuthenticator(), User.redirectMiddleware(path: "/login")])

    protected.get { req -> Response in
        return req.redirect(to: "admin/dashboard")
    }
    
    protected.get("dashboard") { req -> EventLoopFuture<View> in
        
        return req.view.render("admin/dashboard", DashboardContext(try req.auth.require(User.self)))
        
    }
}

struct DashboardContext: Encodable {
    let user: User
    
    init(_ user: User) {
        self.user = user
    }
}
