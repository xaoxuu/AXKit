//
//  TestSwift.swift
//  AXKitDemo
//
//  Created by xaoxuu on 2018/6/8.
//  Copyright © 2018 Titan Studio. All rights reserved.
//

import UIKit
import AXKit

public extension NSString {
    public class func safe(_ obj: String? ...) -> String? {
        var result: String?
        if obj.count > 0 {
            result = obj[0]
            if obj.count > 1 {
                let sec = obj[1]
                result = sec
            }
        }
        
        return result
    }
    @objc public class func safeString(obj: String?, obj2: String?) -> String? {
        return safe(obj, obj2)
    }
    @objc public class func test(){
        safe("ad", "ss", "s")
    }
}


class TestSwift: NSObject {
    
    
    
    
    @objc public class func test(obj: String?, obj2: String?){
        test(obj, obj2)
    }
    
    public class func test(_ obj: String? ...) {
        for tmp in obj {
            print(tmp)
        }
    }
}
