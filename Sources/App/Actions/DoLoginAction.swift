import Vapor
import Fluent

struct DoLoginAction {
    init() { }
    
    func invoke(request: Request) throws -> EventLoopFuture<UserToken> {
        let user = try request.auth.require(User.self)
        let token = try user.generateToken()
        return token.save(on: request.db).map { token }
    }
}
