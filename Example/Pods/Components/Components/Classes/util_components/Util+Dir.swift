//
//  Util+Dir.swift
//  UIComponents
//
//  Created by lidong on 2022/6/14.
//

import Foundation

//文件夹

public class Dir{
    
    //document文件夹路径
    public static var documents:String{
        return URL.documentPath
    }
    
    //缓存文件夹
    public static var caches:String{
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    @discardableResult
    public static func create(_ name:String)->Bool{
        do {
            try FileManager.default.createDirectory(atPath:name.contains("Documents") ? name : documents+name, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
    }
    
    @discardableResult
    public static func remove(_ path:String)->Bool{
        do {
            try FileManager.default.removeItem(atPath: path.contains("Documents") ? path : documents+path)
            return true
        } catch let error as NSError{
            print(error.localizedDescription)
            return false
        }
    }
    
}
