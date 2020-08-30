import Vapor

struct ShowLoginFormAction {
    init() { }
    
    func invoke(request: Request) throws -> EventLoopFuture<View> {
        
        return request.view.render("auth/login")
        
    }
}
