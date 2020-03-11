//
//  StringExtension.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/5.
//  Copyright © 2019 zhangyu. All rights reserved.
//

let YMDFormatter = "YYYY-MM-DD HH:mm:ss"


extension String{
    
   
    //去掉首位空格
    func trim() -> String{
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
//    func bytes() -> Array<UInt8>{
//        return self.data(using: String.Encoding.utf8)?.bytes ?? []
//    }
    
    //范围
    func ToUpper(upper:String) -> String{
        return "\(self)-\(upper)"
    }
    
    //手机号中间显示*
    func phoneNumberSecrecy() -> String{
        if self == "" {
            return ""
        }
        let start = self.index((self.startIndex), offsetBy: 3)
        let end = self.index((self.startIndex), offsetBy: 6)
        return self.replacingCharacters(in:  start...end, with: "****")
    }
    
    //身份证号中间显示*
    func idCardSecrecy() -> String{
        if self.count < 8 {
            return self
        }
        let start = self.index((self.startIndex), offsetBy: 3)
        let end = self.index((self.startIndex), offsetBy: (self.count - 4))
        return self.replacingCharacters(in:  start...end, with: "****")
    }
    
    func https() -> String {
        return self.replacingOccurrences(of: "http:", with: "https:")
    }
    
    
    /// 时间换算成今天和昨天
    func timeDateTransform() -> String {
        var dateStr = ""
        let timeStr = self.components(separatedBy: " ").last
        if let date = DateFormatter().date(from: self){
            if date.isToday() {
                dateStr = "今天"
            }else if date.isYesterday(){
                dateStr = "昨天"
            }
            
            return dateStr + (timeStr ?? "")
        }
       return self
    }
    
    /**
     Get the height with font.
     
     - parameter font:       The font.
     - parameter fixedWidth: The fixed width.
     
     - returns: The height.
     */
    func heightWithFont(font : UIFont = UIFont.systemFont(ofSize: 18), fixedWidth : CGFloat) -> CGFloat {
        
        guard self.count > 0 && fixedWidth > 0 else {
            
            return 0
        }
        let size = CGSize.init(width: fixedWidth, height: 99999)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context:nil)
        
        return rect.size.height
    }
    
    func getDic() -> [String: Any]? {
        let data = self.data(using: .utf8)
        var dicData: Any?
        do {
            dicData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        } catch {}
        if let dic = dicData as? [String: Any] {
            return dic
        }
        return nil
    }
}

extension Date{
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /**
     *  是否为今天
     */
    func isToday() -> Bool{
        let calendar = Calendar.current
        let unit: Set<Calendar.Component> = [.day,.month,.year]
        let nowComps = calendar.dateComponents(unit, from: Date())
        let selfCmps = calendar.dateComponents(unit, from: self)
        
        return (selfCmps.year == nowComps.year) &&
            (selfCmps.month == nowComps.month) &&
            (selfCmps.day == nowComps.day)
        
    }
    
    /**
     *  是否为昨天
     */
    func isYesterday() -> Bool {
        let calendar = Calendar.current
        let unit: Set<Calendar.Component> = [.day,.month,.year]
        let nowComps = calendar.dateComponents(unit, from: Date())
        let selfCmps = calendar.dateComponents(unit, from: self)
        if selfCmps.day == nil || nowComps.day == nil {
            return false
        }
        let count = nowComps.day! - selfCmps.day!
        return (selfCmps.year == nowComps.year) &&
            (selfCmps.month == nowComps.month) &&
            (count == 1)
    }
    
    //月份加减
    func subMonth(sub: Int) -> Date {
        let calculatedDate = Calendar.current.date(byAdding: Calendar.Component.month, value: sub, to: self)
        return calculatedDate!
    }
    
    //日期格式转换-yyyy-MM
    func formatDateToY_M() -> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "YYYY/MM"
        let dateStr = dformatter.string(from: self)
        return dateStr
    }
    
    //日期格式转换-yyyy-MM-dd
    func formatDateToYMD() -> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "YYYY-MM-dd"
        let dateStr = dformatter.string(from: self)
        return dateStr
    }
}



