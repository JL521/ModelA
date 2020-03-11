//
//  MineJobWorkjlTableViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/9.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class MineJobWorkjlTableViewCell: UITableViewCell {

    @IBOutlet weak var rightimgv: UIImageView!
    @IBOutlet weak var companyl: UILabel!
    @IBOutlet weak var zhiweil: UILabel!
    @IBOutlet weak var timel: UILabel!
    @IBOutlet weak var desl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    func setDataWithWorkModel(mode:workExpreModel?)  {
        
        if let model = mode {
            companyl.text = model.companyName
            zhiweil.text = model.positionName
            timel.text = (model.entryTime ?? "") + "-" + (model.leaveTime ?? "")
            
            if model.leaveTime?.contains(" ") ?? false &&  model.entryTime?.contains(" ") ?? false{
                let graduateTimestr = model.leaveTime ?? ""
                var range: Range = graduateTimestr.range(of: " ")!
                var location: Int = graduateTimestr.distance(from: graduateTimestr.startIndex, to: range.lowerBound)
                let graduateTimesubStr = graduateTimestr.prefix(location)
                
                let studyTimestr = model.entryTime ?? ""
                range = studyTimestr.range(of: " ")!
                location = studyTimestr.distance(from: studyTimestr.startIndex, to: range.lowerBound)
                let studyTimesubStr = studyTimestr.prefix(location)
                
                timel.text = studyTimesubStr + "-" + graduateTimesubStr
                mode?.entryTime = "\(studyTimesubStr)"
                mode?.leaveTime = "\(graduateTimesubStr)"
            }
                        
            desl.text = model.jobDesc
        }
        
    }
    
    func setDataWithProjectModel(mode:projectExpreModel?)  {
        
        if let model = mode {
            companyl.text = model.projectName
            zhiweil.text = model.positionName
            
            timel.text = (model.startTime ?? "") + "-" + (model.endTime ?? "")
            if model.startTime?.contains(" ") ?? false &&  model.endTime?.contains(" ") ?? false{
                let graduateTimestr = model.endTime ?? ""
                var range: Range = graduateTimestr.range(of: " ")!
                var location: Int = graduateTimestr.distance(from: graduateTimestr.startIndex, to: range.lowerBound)
                let graduateTimesubStr = graduateTimestr.prefix(location)
                
                let studyTimestr = model.startTime ?? ""
                range = studyTimestr.range(of: " ")!
                location = studyTimestr.distance(from: studyTimestr.startIndex, to: range.lowerBound)
                let studyTimesubStr = studyTimestr.prefix(location)
                
                timel.text = studyTimesubStr + "-" + graduateTimesubStr
                mode?.startTime = "\(studyTimesubStr)"
                mode?.endTime = "\(graduateTimesubStr)"
            }
            
            
            desl.text = model.projectDesc
        }
        
    }
    
    func setDataWithEduModel(mode:MineEduModel?)  {
        
        if let model = mode {
            companyl.text = model.schoolName
            zhiweil.text = (model.education ?? "") + " | " + (model.major ?? "")
            
            timel.text = "\(model.studyTime ?? "")" + "-" + "\(model.graduateTime ?? "")"
            
            if model.graduateTime?.contains(" ") ?? false &&  model.studyTime?.contains(" ") ?? false{
                let graduateTimestr = model.graduateTime ?? ""
                var range: Range = graduateTimestr.range(of: " ")!
                var location: Int = graduateTimestr.distance(from: graduateTimestr.startIndex, to: range.lowerBound)
                let graduateTimesubStr = graduateTimestr.prefix(location)
                
                let studyTimestr = model.studyTime ?? ""
                range = studyTimestr.range(of: " ")!
                location = studyTimestr.distance(from: studyTimestr.startIndex, to: range.lowerBound)
                let studyTimesubStr = studyTimestr.prefix(location)
                
                timel.text = studyTimesubStr + "-" + graduateTimesubStr
                mode?.studyTime = "\(studyTimesubStr)"
                mode?.graduateTime = "\(graduateTimesubStr)"
            }
            
            
            
            
            
            desl.text = nil
        }
        
    }
    
}
