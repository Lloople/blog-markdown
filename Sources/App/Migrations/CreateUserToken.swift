import Fluent

struct CreateUserToken: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("user_tokens")
            .id()
            .field("token", .string, .required)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("expires_at", .date, .required)
            .field("is_revoked", .bool, .required)
            .unique(on: "token")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("tokens").delete()
    }
}
