import XCTest
@testable import APIClient

final class APIClientTests: XCTestCase {

    func testSimpleRequestConstruction() throws {
        let testAuthService = AuthService()
        let client = APIClient(
            authService: testAuthService,
            host: "api.test.com"
        )
        
        XCTAssertEqual(
            client.request("/api/v1/test").url?.absoluteString,
            "https://api.test.com/api/v1/test"
        )
    }
    
    func testRequestConstructionWithQuery() throws {
        let testAuthService = AuthService()
        let client = APIClient(
            authService: testAuthService,
            host: "api.test.com"
        )
        
        XCTAssertEqual(
            client.request("/api/v1/test").url?.absoluteString,
            "https://api.test.com/api/v1/test"
        )
        
        let query = [
            "A": "1",
            "B": "2",
            "C": "3"
        ]
        
        let request = client.request("/api/v1/test", queryItems: query)
        guard let requestString = request.url?.absoluteString else {
            XCTFail()
            return
        }
        
        let components = requestString.components(separatedBy: "?")
        
        XCTAssertEqual(
            components[0],
            "https://api.test.com/api/v1/test"
        )
        
        XCTAssert(components[1].contains("A=1"))
        XCTAssert(components[1].contains("B=2"))
        XCTAssert(components[1].contains("C=3"))
        XCTAssertEqual(components[1].components(separatedBy: "&").count, 3)
        
    }
    
    static var allTests = [
        ("testSimpleRequestConstruction", testSimpleRequestConstruction),
        ("testRequestConstructionWithQuery", testRequestConstructionWithQuery)
    ]

}
