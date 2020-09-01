import Fluent
import Vapor

final class User: Model, Content, ModelAuthenticatable {
    static let schema = "users"
    
    static let usernameKey = \User.$email
    static let passwordHashKey = \User.$password
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "email")
    var email: String
    
    @Field(key: "password")
    var password: String

    init() { }

    init(id: UUID? = nil, email: String, password: String) throws {
        self.id = id
        self.email = email
        self.password = try Bcrypt.hash(password)
    }
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}
