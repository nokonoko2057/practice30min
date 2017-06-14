//
//  d170614_AnimationTableView.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/06/14.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

/*
 
 - [[Swift] 三項演算子のハマり所 - Qiita](http://qiita.com/ohkawa/items/5869682dba1ca01f1437)
 

 
 */


import UIKit

class d170614_AnimationTableView: UITableViewController {
    
  
    
    fileprivate let RootCellIdentifier = "RootCellIdentifier"
    fileprivate let SubCellIdentifier = "SubCellIdentifier"
    fileprivate let extendedSections = NSMutableIndexSet()
    fileprivate let numberOfRowInSection = 7
    
    
    //MARK: - <Normal>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(TableViewRootCell.self, forCellReuseIdentifier: RootCellIdentifier)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: SubCellIdentifier)
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }
    
    
    //MARK: - <UITableViewDataSource>
    
    //section数
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //セクション数を返す
        return 5
    }
    
    //section内のRowsの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*セクション
         true  -> numberOfRowInSection↑のrow数にする？
         false -> 1にする(セクション名のところのみ)
         */
        return isSectionExtended(section) ? numberOfRowInSection : 1
    }
    
    
    //Row内のcellの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         ↓参考で確認しよう
         isRoot:Bool型
         indexPath.row が 0      -> true
         それ以外 -> false
         rowの数が0か否かを確認してる。
         */
        let isRoot = indexPath.row == 0
        
        
        /*
         identifier:String型
         isRoot(セクション内のrowの数)に応じてcellを変更する
         true  -> RootCellIdentifier
         false -> SubCellIdentifier
         */
        let identifier = isRoot ? RootCellIdentifier : SubCellIdentifier
        
        /*
         上で取得したcellの名前に応じて変更するcellを設定する
         */
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        /*
         ここからcellの設定
         isRootに応じて変える
         */
        if isRoot {
            //上のcellのアンラップ。nil判定。if cell != nil と同じ
            if let cell = cell as? TableViewRootCell {
                
                //cellの内容設定
                cell.label.text = "Section \(indexPath.section)"
                cell.backgroundColor = UIColor(white: CGFloat(0.5 - 0.5 * Double(indexPath.section) / Double(tableView.numberOfSections)), alpha: 1.0)
                cell.label.textColor = UIColor.white
                
                //cellの種類に応じて内容変更。中身みて見よう。
                cell.extended = isSectionExtended(indexPath.section)
            }
        } else {
            
            cell.textLabel?.text = "indexPath(\(indexPath.section), \(indexPath.row))";
        }
        return cell
    }
    
    //MARK: - <UITableViewDelegate>
    
    //cellの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        let isRoot = indexPath.row == 0
        if isRoot {
            return isSectionExtended(indexPath.section) ? 30 : 60
        } else {
            return 44
        }
    }
    
    //cellがタップされたら
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        let isRoot = indexPath.row == 0
        if isRoot {
            didSelectRootCell(indexPath.section)
        }
    }
    
    
    //MARK: - TableviewCustom
    
    
    //cellがタップされた時に呼ばれるメソッド
    fileprivate func didSelectRootCell(_ section: NSInteger) {
        var extended = isSectionExtended(section)
        extended = !extended
        if extended {
            extendedSections.add(section)
        } else {
            extendedSections.remove(section)
        }
        
        let numOfRows = numberOfRowInSection
        var paths = [IndexPath]()
        for i in 1..<numOfRows {
            paths.append(IndexPath(row: i, section: section))
        }
        //        tableView.reloadData()
        //        tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
        tableView.beginUpdates()
        if extended {
            tableView.insertRows(at: paths, with: .automatic)
        } else {
            tableView.deleteRows(at: paths, with: .automatic)
        }
        tableView.endUpdates()
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: section)) as? TableViewRootCell {
                cell.extended = extended
            }
        })
    }
    
    //Sectionが拡大してるかどうかの判定
    fileprivate func isSectionExtended(_ section: NSInteger) -> Bool {
        print("secton\(section) is \(extendedSections.contains(section))")
        return extendedSections.contains(section)
    }

}


//MARK: - TableViewRootCell

class TableViewRootCell: UITableViewCell {
    
    var initialHeight: CGFloat = 60.0
    fileprivate var scale: CGFloat = 1.0
    fileprivate let cross = UIImageView()
    let label = UILabel()
    
    var extended: Bool {
        didSet {
            let angle: CGFloat = self.extended ? CGFloat(M_PI * 45 / 180) : 0
            let t = CGAffineTransformExtractScale(cross.transform)
            cross.transform = t.rotated(by: angle)
        }
    }
    
    override var frame: CGRect {
        didSet {
            scale = self.frame.size.height / initialHeight
            label.transform = CGAffineTransform(scaleX: scale, y: scale)
            let t = CGAffineTransformExtractRotation(cross.transform)
            cross.transform = t.scaledBy(x: scale, y: scale)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        extended = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        extended = false
        super.init(coder: aDecoder)
        self.setupViews()
        self.setupConstraints()
    }
    
    fileprivate func setupViews() {
        cross.translatesAutoresizingMaskIntoConstraints = false
        cross.image = UIImage(named: "cross")
        self.contentView.addSubview(cross)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        self.contentView.addSubview(label)
    }
    
    fileprivate func setupConstraints() {
        let triangleLeading = NSLayoutConstraint(item: cross, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0)
        let triangleCenterY = NSLayoutConstraint(item: cross, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let labelCenterX = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let labelCenterY = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([triangleLeading, triangleCenterY, labelCenterX, labelCenterY])
    }
}

//MARK: - CGAffineTransform

extension CGAffineTransform {
    var scale: (sx: CGFloat, sy: CGFloat) {
        return (sqrt(a * a + c * c), sqrt(b * b + d * d))
    }
    var angle: CGFloat {
        return atan2(b, a)
    }
}

func CGAffineTransformExtractScale(_ t: CGAffineTransform) -> CGAffineTransform {
    let (sx, sy) = t.scale
    return CGAffineTransform(scaleX: sx, y: sy)
}

func CGAffineTransformExtractRotation(_ t: CGAffineTransform) -> CGAffineTransform {
    let angle = t.angle
    return CGAffineTransform(rotationAngle: angle)
}


