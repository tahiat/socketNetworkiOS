//
//  ConnectionManager.swift
//  socketNewtork
//
//  Created by Tahiatul Islam on 11/8/24.
//

import Foundation
import CocoaAsyncSocket

public class ConnectionManager: NSObject, GCDAsyncSocketDelegate {
    
    public static let shared = ConnectionManager()
    private var socket: GCDAsyncSocket?
    private let queue = DispatchQueue.global(qos: .default)
    private override init() {
      
    }
    
    
    public func setupSocket() {
        socket = GCDAsyncSocket(delegate: self, delegateQueue: queue)
        
        do {
            try socket?.connect(toHost: "192.168.1.158", onPort: 8000)
        }
        catch {
            print("Erro: \(error)")
        }
    }
    
    func connectToServer() {
        do {
            //try socket?.connect(toHost: "192.168.1.158", onPort: 8000)
            try socket?.connect(toHost: "192.168.1.158", onPort: 8000, withTimeout: -1)
        }
        catch {
            print("Erro: \(error)")
        }
    }
    
    public func socket(_ sock: GCDAsyncSocket, didReadPartialDataOfLength partialLength: UInt, tag: Int) {
        print("data \(partialLength)")
    }
    
    public func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        
        let stringData = String(data: data, encoding: .utf8)
        
        print("data received \(String(describing: stringData))")
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    public func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        sock.readData(withTimeout: -1, tag: 0)
        print("coonecte host \(host): \(port)")
        
    }
    
    public func socket(_ sock: GCDAsyncSocket, didConnectTo url: URL) {
        print("coonect \(url)")
    }
    
   
    
    public func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: (any Error)?) {
        print("error disconnect")
        self.connectToServer()
    }
    public func emitData () {
        if let soc = socket, soc.isConnected {
            let da = "hello".data(using: .utf8)
            
            soc.write(da, withTimeout: -1, tag: 0)
        }
    }
    
    
    
    public func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
            print("Data sent to the server!  \(tag)")
    }
    
    public func socketDidCloseReadStream(_ sock: GCDAsyncSocket) {
        print("read stream closed")
        sock.readData(withTimeout: -1, tag: 0)
    }
}
