//
//  Extension+UIButton.swift
//  ModuleProject
//
//  Created by guoqiang on 2021/11/2.
//

import UIKit

public extension UIButton {
    
    convenience init(frame: CGRect = .zero, target: Any?, action: Selector) {
        self.init(type: .custom)
        self.frame = frame
        isExclusiveTouch = true
        addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    convenience init(frame: CGRect = .zero,_ action: ButtonEventsAction? = nil) {
        self.init(type: .custom)
        self.frame = frame
        isExclusiveTouch = true
        self.tapAction = action
    }
    
    convenience init(image:UIImage?,target: Any?, action: Selector){
        self.init(type: .custom)
        self.setImage(image, for: UIControl.State.normal)
        self.sizeToFit()
        isExclusiveTouch = true
        addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    convenience init(image:UIImage?, _ action: ButtonEventsAction? = nil){
        self.init(type: .custom)
        self.setImage(image, for: UIControl.State.normal)
        self.sizeToFit()
        isExclusiveTouch = true
        self.tapAction = action
    }
    
    convenience init(image:UIImage?,size: CGSize,target: Any?, action: Selector){
        self.init(type: .custom)
        self.setImage(image, for: UIControl.State.normal)
        self.sizeToFit()
        let bounds: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        if bounds.contains(self.bounds) {
            self.bounds = bounds
        }
        isExclusiveTouch = true
        addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    //button文本宽度
    var titleWidth: CGFloat {
        guard let text = titleLabel?.text, let font = titleLabel?.font else { return 0 }
        return text.size(withAttributes: [.font: font]).width
    }
}

public typealias ButtonEventsAction = (UIButton)->()

/// UIButton 增加block 回调

public extension UIButton{
    //运行时存储Key
    private struct AssociatedKeys{
        static var actionKey = "actionKey"
    }
        
    @objc fileprivate dynamic var actionDict: [String:Any]? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let dic = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? [String:Any]{
                return dic
            }
            return nil
        }
    }
    
    
    /// UIControl.Event 获取字符串描述
    /// - Parameter events:  UIControl.Event
    /// - Returns: 字符串描述
    fileprivate func string(with events:UIControl.Event)->String{
        return String(describing: events.rawValue)
    }
    
    @objc dynamic fileprivate func add(with action: ButtonEventsAction? ,for controlEvents: UIControl.Event) {
        if let action = action {
            let eventStr = string(with: controlEvents)
            if let _ = actionDict {
                //将acton block 传入到字典
                self.actionDict?[eventStr] = action
            }else{
                //新创建字典 set action to  字典中
                self.actionDict = [eventStr:action]
            }
            switch controlEvents {
            case .touchUpInside:
                self.addTarget(self, action: #selector(touchUpInSideAction(btn:)), for: .touchUpInside)
            case .touchUpOutside:
                self.addTarget(self, action: #selector(touchUpOutsideAction(btn:)), for: .touchUpOutside)
            case .touchCancel:
                self.addTarget(self, action: #selector(touchCancelAction(btn:)), for: .touchCancel)
            case .touchDown:
                self.addTarget(self, action: #selector(touchDownAction(btn:)), for: .touchDown)
            default:
                //这里以后根据需要在扩展其它点击事件
                break
            }
        }
    }

    @objc fileprivate func touchUpInSideAction(btn: UIButton) {
        if let actionDict = self.actionDict  {
            if let action = actionDict[string(with: .touchUpInside)] as? ButtonEventsAction{
                action(self)
            }
        }
    }
    
    @objc fileprivate func touchUpOutsideAction(btn: UIButton) {
        if let actionDict = self.actionDict  {
            if let action = actionDict[string(with: .touchUpOutside)] as? ButtonEventsAction{
                action(self)
            }
        }
    }
    
    @objc fileprivate func touchCancelAction(btn: UIButton) {
        if let actionDict = self.actionDict  {
            if let action = actionDict[string(with: .touchCancel)] as? ButtonEventsAction{
                action(self)
            }
        }
    }
    
    @objc fileprivate func touchDownAction(btn: UIButton) {
        if let actionDict = self.actionDict  {
            if let action = actionDict[string(with: .touchDown)] as? ButtonEventsAction{
                action(self)
            }
        }
    }
    
    //按钮点击起来的回调
    var tapAction:ButtonEventsAction?{
        set{
            self.add(with: newValue, for: .touchUpInside)
        }
        get{
            let strKey = self.string(with: .touchUpInside)
            if let actionDict = actionDict {
                return actionDict[strKey] as? ButtonEventsAction
            }
            return nil
        }
    }
    
    /// 按钮离开回调
    var tapOutAction:ButtonEventsAction?{
        set{
            self.add(with: newValue, for: .touchUpOutside)
        }
        get{
            let strKey = self.string(with: .touchUpOutside)
            if let actionDict = actionDict {
                return actionDict[strKey] as? ButtonEventsAction
            }
            return nil
        }
    }
    
    /// 按钮取消回调
    var tapCancelAction:ButtonEventsAction?{
        set{
            self.add(with: newValue, for: .touchCancel)
        }
        get{
            let strKey = self.string(with: .touchCancel)
            if let actionDict = actionDict {
                return actionDict[strKey] as? ButtonEventsAction
            }
            return nil
        }
    }
    
    
    /// 按钮按下回调
    var tapDownAction:ButtonEventsAction?{
        set{
            self.add(with: newValue, for: .touchDown)
        }
        get{
            let strKey = self.string(with: .touchDown)
            if let actionDict = actionDict {
                return actionDict[strKey] as? ButtonEventsAction
            }
            return nil
        }
    }
    
}
