//
//  CollectionViewController.swift
//  CollectionViewTest
//
//  Created by 刘佳艳 on 2019/11/04.
//  Copyright © 2019 刘佳艳. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController {

    //建议 数组嵌套  大数组 里面2个小数组 (相当于2个section) 小数组里面数据(cell)
    let imageNames = [
        ["p1","p2"],
        ["p3","p4"]
    ]
    let itemPerRow:CGFloat = 2 //每行显示2个
    //这里定义以后 取出来的10都是cgfloat 方便下面计算
    let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //这句和在ui里面写id一样 所以可以注掉
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return imageNames.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageNames[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!CollectionViewCell
    
        // Configure the cell
        cell.imageView.image = UIImage(named: imageNames[indexPath.section][indexPath.row])
    
        return cell
    }

    //这个方法就是用来配置补充视图,获取section head foot的 页眉页脚
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //使用自带flow布局就是页眉和页脚,kind判断页眉还是页脚
        switch kind {
        case UICollectionView.elementKindSectionHeader://常量判断是页眉还是页脚
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as!CollectionReusableView
            let texts = ["今天拍的","昨天拍的"]
            
            sectionHeader.lbText.text = texts[indexPath.section]
            return sectionHeader
        default:
            return UICollectionReusableView() //返回一个空  因为没写footer
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
//动态设置cell各种属性大小
extension CollectionViewController:UICollectionViewDelegateFlowLayout{
    
    //cell内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }
    //cell最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInset.left //因为长宽相等 随便取
    }
    //最小行距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInset.bottom //因为长宽相等 随便取
    }
    //cell尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //cell宽度 = 手机宽度 减去 各种边距 除以 cell个数   正方形长宽相等  (各种间距 = 间距*cell数量+1)
        let itemWith =  (view.bounds.width - sectionInset.bottom*(itemPerRow+1))/itemPerRow
        return CGSize(width: itemWith, height: itemWith) //算出cell大小,长宽相等
    }
}
