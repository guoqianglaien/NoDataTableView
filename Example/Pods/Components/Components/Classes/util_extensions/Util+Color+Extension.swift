
import UIKit

public extension UIColor {
    
    var r:CGFloat{
       return colorComponents().0
    }
    
    var g:CGFloat{
        return colorComponents().1
    }
    
    var b:CGFloat{
        return colorComponents().2
    }
    
    var alpha:CGFloat{
        return colorComponents().3
    }
    
    ///"#4DA2D9","#4DA2D9CC","0x4DA2D9"
    convenience init(_ hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    //0x4DA2D9
    convenience init(hexInt: Int, alpha: Float = 1.0) {
        let hexString = String(format: "%06X", hexInt)
        self.init(hexString: hexString, alpha: alpha)
    }
    
    convenience init(hexString: String, alpha: Float = 1.0) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var mAlpha: CGFloat = CGFloat(alpha)
        var minusLength = 0
        
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            if #available(iOS 13.0, *) {
                scanner.currentIndex = scanner.string.index(scanner.string.startIndex, offsetBy: "#".count)
            }
            minusLength = 1
        }
        if hexString.hasPrefix("0x") {
            if #available(iOS 13.0, *) {
                scanner.currentIndex = scanner.string.index(scanner.string.startIndex, offsetBy: "0x".count)
            }
            minusLength = 2
        }
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        switch hexString.count - minusLength {
        case 3:
            red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
            green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
            blue = CGFloat(hexValue & 0x00F) / 15.0
        case 4:
            red = CGFloat((hexValue & 0xF000) >> 12) / 15.0
            green = CGFloat((hexValue & 0x0F00) >> 8) / 15.0
            blue = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
            mAlpha = CGFloat(hexValue & 0x000F) / 15.0
        case 6:
            red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(hexValue & 0x0000FF) / 255.0
        case 8:
            red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
            green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
            mAlpha = CGFloat(hexValue & 0x000000FF) / 255.0
        default:
            break
        }
        self.init(red: red, green: green, blue: blue, alpha: mAlpha)
    }
    
    /// color components value between 0 to 255
    convenience init(byteRed red: Int, green: Int, blue: Int, alpha: Float = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    
    func alpha(_ value: Float) -> UIColor {
        let (red, green, blue, _) = colorComponents()
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(value))
    }
    
    func red(_ value: Int) -> UIColor{
        let (_, green, blue, alpha) = colorComponents()
        return UIColor(red: CGFloat(value)/255.0, green: green, blue: blue, alpha: alpha)
    }
    
    func green(_ value: Int) -> UIColor {
        let (red, _, blue, alpha) = colorComponents()
        return UIColor(red: red, green: CGFloat(value)/255.0, blue: blue, alpha: alpha)
    }
    
    func blue(_ value: Int) -> UIColor {
        let (red, green, _, alpha) = colorComponents()
        return UIColor(red: red, green: green, blue: CGFloat(value)/255.0, alpha: alpha)
    }
    
    //获取各个颜色组件值
    func colorComponents() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
}
