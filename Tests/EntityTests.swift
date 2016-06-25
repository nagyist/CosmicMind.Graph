/*
 * Copyright (C) 2015 - 2016, CosmicMind, Inc. <http://cosmicmind.io>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import XCTest
@testable import Graph

class EntityTests: XCTestCase, GraphDelegate {
    var saveException: XCTestExpectation?
    var delegateException: XCTestExpectation?
    
    var graph: Graph!
    
    override func setUp() {
        super.setUp()
        graph = Graph()
        graph.delegate = self
        graph.watchForEntity(types: ["T"])
    }
    
    override func tearDown() {
        graph = nil
        super.tearDown()
    }
    
    func testAll() {
        let n = Entity(type: "T")
        n["p"] = "v"
        n.addToGroup("g")
        
        XCTAssertTrue("v" == n["p"] as? String)
        
        saveException = expectationWithDescription("[EntityTests Error: Save Etity test failed.]")
        delegateException = expectationWithDescription("[EntityTests Error: Delegate Etity test failed.]")
        
        graph.save { [weak self] (success: Bool, error: NSError?) in
            self?.saveException?.fulfill()
            XCTAssertTrue(success)
        }
        
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
//    func namedGraphSave() {
//        let g = Graph(name: "EntityTests-namedGraphSave")
//        g.clear()
//        
//        g.watchForEntity(types: ["T"])
//        g.delegate = self
//        
//        let e = Entity(type: "T", graph: "EntityTests-namedGraphSave")
//        e["p"] = "v"
//        e.addToGroup("g")
//        
//        XCTAssertTrue("v" == e["p"] as? String)
//        
//        saveException = expectationWithDescription("[EntityTests Error: Save Etity test failed.]")
//        delegateException = expectationWithDescription("[EntityTests Error: Delegate Etity test failed.]")
//        
//        g.save { [weak self] (success: Bool, error: NSError?) in
//            self?.saveException?.fulfill()
//            XCTAssertTrue(success)
//        }
//        
//        waitForExpectationsWithTimeout(5, handler: nil)
//    }
//    
//    func referenceGraphSave() {
//        let g = Graph(name: "EntityTests-referenceGraphSave")
//        g.clear()
//        
//        g.watchForEntity(types: ["T"])
//        g.delegate = self
//        
//        let e = Entity(type: "T", graph: g)
//        e["p"] = "v"
//        e.addToGroup("g")
//    
//        XCTAssertTrue("v" == e["p"] as? String)
//        
//        saveException = expectationWithDescription("[EntityTests Error: Save Etity test failed.]")
//        delegateException = expectationWithDescription("[EntityTests Error: Delegate Etity test failed.]")
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] in
//            g.save { [weak self] (success: Bool, error: NSError?) in
//                self?.saveException?.fulfill()
//                XCTAssertTrue(success)
//            }
//        }
//        
//        waitForExpectationsWithTimeout(5, handler: nil)
//    }
//    
//    func asyncGraphSave() {
//        saveException = expectationWithDescription("[EntityTests Error: Save Etity test failed.]")
//        delegateException = expectationWithDescription("[EntityTests Error: Delegate Etity test failed.]")
//        
//        var g: Graph!
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] in
//            g = Graph(name: "EntityTests-asyncGraphSave")
//            g.clear()
//            
//            g.watchForEntity(types: ["T"])
//            g.delegate = self
//        
//            let e = Entity(type: "T", graph: g)
//            e["p"] = "v"
//            e.addToGroup("g3")
//        
//            XCTAssertTrue("v" == e["p"] as? String)
//        
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] in
//                g.save { [weak self] (success: Bool, error: NSError?) in
//                    self?.saveException?.fulfill()
//                    XCTAssertTrue(success)
//                }
//            }
//        }
//        
//        waitForExpectationsWithTimeout(5, handler: nil)
//    }
    
    func graphDidInsertEntity(graph: Graph, entity: Entity) {
        delegateException?.fulfill()
    }
}