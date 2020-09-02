@testable import App
import XCTVapor

final class AuthTests: TestCase {
    
    func test_can_access_login_page() throws {
        try app.test(.GET, "login") { res in
            XCTAssertEqual(res.status, .ok)
        }
    }
    
    func test_login_redirects_back_if_failed() throws {
        try app.test(.POST, "login", beforeRequest: { req in
            try req.content.encode([
                "email": "user@example.com",
                "password": "password"
            ])
        }) { res in
            
            // TODO: Add some session error message
            
            XCTAssertEqual(res.status, .seeOther)
            XCTAssertEqual(res.headers.first(name: "location"), "login")
        }
    }

func test_user_can_log_in() throws {
    
    let user = try User(email: "user@example.com", password: "password")
    try user.create(on: app.db).wait()
    
    try app.test(.POST, "login", beforeRequest: { req in
        try req.content.encode([
            "email": "user@example.com",
            "password": "password"
        ])
    }) { res in
        XCTAssertEqual(res.status, .seeOther)
        XCTAssertEqual(res.headers.first(name: "location"), "/dashboard")
        
        
        // TODO: Check user id is stored in session
    }
}
    
}
