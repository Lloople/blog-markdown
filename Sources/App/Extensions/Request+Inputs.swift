import Vapor

extension Request {
    
    func inputString(_ input: String) throws -> String {
        return try self.content.get(String.self, at: input)
    }
}
