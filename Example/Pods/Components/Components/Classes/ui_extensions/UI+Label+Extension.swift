//
//  UI+Label+Extension.swift
//  UIComponents
//
//  Created by lidong on 2022/5/30.
//

import Foundation
import UIKit


public extension UILabel {
    
    /// 创建UILabel
    /// - Parameters:
    ///   - frame: frame
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - font: 文本字体
    ///   - textAligment: 对齐方式
    convenience init(frame:CGRect = .zero, text:String? = nil,textColor:UIColor? = nil,font:UIFont? = nil,textAligment:NSTextAlignment? = nil) {
        self.init(frame: frame)
        if let textColor = textColor {
            self.textColor = textColor
        }
        if let font = font {
            self.font = font
        }
        self.text = text
        if let textAligment = textAligment {
            self.textAlignment = textAligment
        }
    }
    
    
    /// 创建UILabel
    /// - Parameters:
    ///   - frame: frame
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - textAligment: 对齐方式
    convenience init(frame:CGRect = .zero, text:String? = nil,textColor:UIColor? = nil,textAligment:NSTextAlignment? = nil) {
        self.init(frame: frame, text: text, textColor: textColor, font: nil, textAligment: textAligment)
    }

    /// 根据文本label可以显示的最大行数
    var maxNumberOfLines:Int{
        let lineHeight = font.lineHeight
        return Int(ceil(self.maxTextHeight / lineHeight))
    }
    
    ///label文本最大高度
    var maxTextHeight:CGFloat{
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font as Any], context: nil).height
       return textHeight
    }
}

