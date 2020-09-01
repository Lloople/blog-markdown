import Vapor
import Fluent

struct DoLoginAction {
    init() { }
    
    let urlFail: String = "auth/login"
    let urlSuccess: String = "dashboard"
    
    func invoke(request: Request) throws -> EventLoopFuture<Response> {
        
        return try User.query(on: request.db)
            .filter(\.$email == request.inputString("email"))
            .first()
            .unwrap(or: Abort.redirect(to: self.urlFail))
            .flatMapThrowing { user in
                if try user.verify(password: request.inputString("password")) {
                    // TODO: Store user id in the session
                    return request.redirect(to: self.urlSuccess)
                }
                
                return request.redirect(to: self.urlFail)
            }
    }
}
