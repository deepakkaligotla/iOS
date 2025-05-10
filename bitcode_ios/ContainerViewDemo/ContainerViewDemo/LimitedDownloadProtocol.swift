//
//  LimitedDownloadProtocol.swift
//  ContainerViewDemo
//
//  Created by Deepak Kaligotla on 06/05/25.
//

import Foundation

class LimitedDownloadProtocol: URLProtocol, URLSessionDataDelegate {
    static let maxBytes = 2048
    private var dataTask: URLSessionDataTask?
    private var receivedData = Data()

    override class func canInit(with request: URLRequest) -> Bool {
        if URLProtocol.property(forKey: "Handled", in: request) != nil {
            return false
        }
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        let mutableRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        URLProtocol.setProperty(true, forKey: "Handled", in: mutableRequest)
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        dataTask = session.dataTask(with: mutableRequest as URLRequest)
        dataTask?.resume()
    }

    override func stopLoading() {
        dataTask?.cancel()
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        receivedData.append(data)
        
        let remainingData = max(0, Self.maxBytes - receivedData.count)
        if remainingData > 0 {
            let trimmedData = data.prefix(remainingData)
            receivedData.append(trimmedData)
            client?.urlProtocol(self, didLoad: trimmedData)
        }

        if receivedData.count >= Self.maxBytes {
            client?.urlProtocolDidFinishLoading(self)
            dataTask.cancel()
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocolDidFinishLoading(self)
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        completionHandler(.allow)
    }
}
