//
//  MockURLProtocol.swift
//  CatChallengeTests
//
//  Created by goncaloalmeida on 05/06/2024.
//

import Foundation

final class MockUrlProtocol: URLProtocol {
    static var testData: Data?
    static var response: URLResponse?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockUrlProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {
            if let response = MockUrlProtocol.response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = MockUrlProtocol.testData {
                self.client?.urlProtocol(self, didLoad: data)
            }
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {}
}
