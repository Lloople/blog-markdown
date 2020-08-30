import Fluent
import FluentMySQLDriver
import Vapor

public func configure(_ app: Application) throws {

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    connectDatabase(app)

    setMigrations(app)

    try routes(app)
}

func connectDatabase(_ app: Application) -> Void {
    app.databases.use(.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "127.0.0.1",
        username: Environment.get("DATABASE_USERNAME") ?? "vapor",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor",
        database: Environment.get("DATABASE_NAME") ?? "blog_markdown",
        tlsConfiguration: .forClient(certificateVerification: .none)
    ), as: .mysql)
}

func setMigrations(_ app: Application) -> Void {
    app.migrations.add(CreateUser())
    app.migrations.add(CreateUserToken())
    app.migrations.add(CreatePost())
}
