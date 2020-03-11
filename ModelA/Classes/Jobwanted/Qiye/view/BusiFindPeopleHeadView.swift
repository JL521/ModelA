//
//  BusiFindPeopleHeadView.swift
//  Rencaiyoujia
//
//  Created by 姜磊 on 2020/2/11.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class BusiFindPeopleHeadView: UIView ,UISearchBarDelegate{
    @IBOutlet weak var searchBar: UISearchBar!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     
    */
    
    override func awakeFromNib() {
        searchBar.delegate = self
    }
    
    var regionBlock: ((_ type : Int)->())?
    var searchBlock: ((_ str : String?)->())?
    @IBOutlet weak var prol: UILabel!
    
    @IBOutlet weak var cityl: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var proBtn: UIButton!
    @IBAction func btnclick(_ sender: UIButton) {
        
        print("选择地区")
        if let block = self.regionBlock {
            block(sender.tag)
        }
        
    }
    
    @IBAction func search(_ sender: Any) {
        searchBar.resignFirstResponder()
        if let block = self.searchBlock {
            block(searchBar.text)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let block = self.searchBlock {
            block(searchBar.text)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let block = self.searchBlock {
            block(searchBar.text)
        }
    }
    
}
