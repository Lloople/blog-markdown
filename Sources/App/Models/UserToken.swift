import Fluent
import Vapor


final class UserToken: Model, Content, ModelTokenAuthenticatable {
    typealias User = App.User // I don't know what this does
    
    static let schema = "user_tokens"
    
    static let valueKey = \UserToken.$token
    static let userKey = \UserToken.$user
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "token")
    var token: String
    
    @Parent(key: "user_id")
    var user: User
    
    @Field(key: "expires_at")
    var expiresAt: Date
    
    @Field(key: "is_revoked")
    var isRevoked: Bool
    
    init() { } // Why is this empty constructor required?
    
    init(id: UUID? = nil, token: String, userId: User.IDValue) {
        self.id = id
        self.token = token
        self.$user.id = userId
        self.expiresAt = Date().advanced(by: 60 * 60 * 24 * 30)
        self.isRevoked = false
    }
    
    var isValid: Bool {
        return self.expiresAt > Date() && !self.isRevoked
    }
}
