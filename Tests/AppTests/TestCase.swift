@testable import App
import XCTVapor

final class TestCase: XCTestCase {
    
    let app: Application = Application(.testing)
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        setenv("DATABASE_NAME", "testingdatabase", 1)
        
        try configure(self.app)
        
        try app.autoMigrate().wait()
    }
    
    override func tearDownWithError() throws {
        User.query(on: app.db).delete().wait()
        
        app.shutdown()
        
        super.tearDownWithError()
    }
}
