//
//  ResumeFJTableViewCell.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2020/1/16.
//  Copyright © 2020 zhangyu. All rights reserved.
//

import UIKit

class ResumeFJTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collv: UICollectionView!
    var dataArr:[String]?
    var selectblock:((_ str : String)->())?
    var type : Int?
    var delblock:((_ str : String)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 60, height: 60);
        layout.minimumLineSpacing = 20;
        layout.scrollDirection = .horizontal;
        layout.minimumInteritemSpacing = 20;
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collv.setCollectionViewLayout(layout, animated: false)
        self.collv.delegate = self;
        self.collv.dataSource = self;
        self.collv.register(UINib(nibName: "FJresumeCollectionViewCell", bundle: BundleTool.getBundle()), forCellWithReuseIdentifier: "FJresumeCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(arr:[String]?) {
        dataArr = arr
        collv.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FJresumeCollectionViewCell", for: indexPath) as! FJresumeCollectionViewCell
        let str = dataArr?[indexPath.row]
        if str?.range(of: "http") == nil {
            cell.delbtn.isHidden = false
        }else{
            cell.delbtn.isHidden = true
        }
        
        if let t = type {
            if t == 1 {
            cell.delbtn.isHidden = true
            }
        }
        
        cell.block = {
            if let myb = self.delblock{
                myb(str ?? "")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let block = selectblock {
            block((dataArr?[indexPath.row])!)
        }
    }
    
}
