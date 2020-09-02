import Vapor
import Fluent

struct DoLoginAction {
    init() { }
    
    let urlFail: String = "/login"
    let urlSuccess: String = "/admin/dashboard"
    
    func invoke(request: Request) throws -> EventLoopFuture<Response> {
        
        return try User.query(on: request.db)
            .filter(\.$email == request.inputString("email"))
            .first()
            .unwrap(or: Abort.redirect(to: self.urlFail))
            .flatMapThrowing { user in
                if try user.verify(password: request.inputString("password")) {

                    request.session.authenticate(user)

                    return request.redirect(to: self.urlSuccess)
                }
                
                return request.redirect(to: self.urlFail)
            }
    }
}
