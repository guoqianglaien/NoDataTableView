//
//  Util+Json.swift
//  UIComponents
//
//  Created by lidong on 2022/6/14.
//

import Foundation

public class JsonX{
    //json是否有效
    public static func isValid(_ filePath:String)->Bool{
        if let _ = filePath.content?.data?.json{
            return true
        }
        return false
    }
    
    //read json
    public static func read(filePath:String)->[String:Any]?{
        return filePath.content?.data?.json
    }
    
    //read json to model
    public static func read<T:Codable>(filePath:String)->T?{
        if let data = filePath.contentData{
            do {
                let decodedData = try JSONDecoder().decode(T.self,
                                                from: data)
                return decodedData
            } catch {
                print("decode error")
            }
        }
        return nil
    }
    
    //读json to 模型数组 
    public static func read<T:Codable>(filePath:String)->[T]?{
        if let data = filePath.contentData{
            do {
                let decodedData = try JSONDecoder().decode([T].self,
                                                from: data)
                return decodedData
            } catch {
                print("decode error")
            }
        }
        return nil
    }
    
    //Write json
    @discardableResult
    public static func write(filePath:String, json:[String:Any])->Bool{
        guard let data = json.jsonData() else{
            return false
        }
        do{
            try data.write(to: filePath.url)
            return true
        }catch{
            return false
        }
    }
    
    //保存模型成json
    public static func write<T:Codable>(filePath:String,model:T)->Bool{
        if let data = try? JSONEncoder().encode(model){
            do{
               try data.write(to: filePath.url)
                return true
            }catch{
            }
        }
        return false
    }
    
    //保存模型数组成json
    public static func write<T:Codable>(filePath:String,models:[T])->Bool{
        if let data = try? JSONEncoder().encode(models){
            do{
               try data.write(to: filePath.url)
                return true
            }catch{
            }
        }
        return false
    }
    
}
