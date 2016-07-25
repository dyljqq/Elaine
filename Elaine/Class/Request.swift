//
//  Request.swift
//  Elaine
//
//  Created by 季勤强 on 16/7/25.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import Foundation

public class Request {
    
    public var task: NSURLSessionTask { return delegate.task }
    
    public var session: NSURLSession
    
    public let delegate: TaskDelegate
    
    init(session: NSURLSession, task: NSURLSessionDataTask) {
        self.session = session
        
        delegate = TaskDelegate(task: task)
    }
    
    public func resume() {
        task.resume()
    }
    
    // MARK: - DataDelegate
    
    public class TaskDelegate: NSObject {
        
        // The serial operation queue used to execute all operations after the task completes.
        public let queue: NSOperationQueue
        
        let task: NSURLSessionTask
        
        var data: NSData? { return nil }
        var error: NSError?
        
        init(task: NSURLSessionTask) {
            self.task = task
            
            self.queue = {
                let operationQueue = NSOperationQueue()
                operationQueue.maxConcurrentOperationCount = 1
                operationQueue.suspended = true
                return operationQueue
            }()
        }
        
        deinit {
            queue.cancelAllOperations()
            queue.suspended = false
        }
        
        var taskDidCompleteWithError: ((NSURLSession, NSURLSessionTask, NSError?)-> Void)?
        
        func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
            if let taskDidCompleteWithError = taskDidCompleteWithError {
                taskDidCompleteWithError(session, task, error)
            } else {
                if let error = error {
                    self.error = error
                }
                
                queue.suspended = false
            }
        }
        
    }
    
}