@testable import App
import XCTVapor

class TestCase: XCTestCase {
    
    let app: Application = Application(.testing)
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        setenv("DATABASE_NAME", "testingdatabase", 1)
        
        try configure(self.app)
        
        try app.autoMigrate().wait()
    }
    
    override func tearDownWithError() throws {
        
        try app.autoRevert().wait()
        
        app.shutdown()
        
        try super.tearDownWithError()
    }
}
