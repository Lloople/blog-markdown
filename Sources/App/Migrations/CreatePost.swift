import Fluent

struct CreatePost: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("posts")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("title", .string, .required)
            .field("slug", .string, .required)
            .field("content", .string, .required)
            .unique(on: "slug")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("posts").delete()
    }
}
