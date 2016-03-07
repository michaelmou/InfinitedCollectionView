//
//  ViewController.swift
//  TestCollectionView
//
//  Created by MichaelMou on 15/7/14.
//  Copyright (c) 2015年 MichaelMou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let identifier = "identifier"
    @IBOutlet var collectionVIew: UICollectionView!
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    //change the count of cell, it can set at least 1 but the
    let countOfCell = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionVIew.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        self.flowLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 300)
        self.flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.flowLayout.sectionInset = UIEdgeInsetsMake(200, 0, 100, 0)
        self.flowLayout.minimumInteritemSpacing = 0
        self.flowLayout.minimumLineSpacing = 0
        self.collectionVIew.pagingEnabled = true
        self.collectionVIew.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return countOfCell + 2
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionVIew.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) 
        
        var index:Int = indexPath.row - 1
        if index < 0 {
            index = countOfCell - 1
        }else if index >= countOfCell{
            index = 0
        }
        cell.contentView.backgroundColor = index % 2 == 0 ? UIColor.grayColor() : UIColor.whiteColor()
        var label:UILabel
        if let view = cell.viewWithTag(1){
            label = view as! UILabel
            
        }else{
            label = UILabel()
            label.font = UIFont.systemFontOfSize(200)
            label.textColor = UIColor.blackColor()
            label.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(label)
            NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: cell.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0).active = true
            NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: cell.contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0).active = true

            label.tag = 1
        }
        
        label.text = "\(index)"
        
        return cell
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentSize = scrollView.contentSize
        let contentOffset = scrollView.contentOffset
        
        let widthPerCell = contentSize.width / CGFloat(countOfCell + 2)
        
        if contentOffset.x <= 0{
            scrollView.contentOffset = CGPointMake(widthPerCell * CGFloat(countOfCell), 0)
        }else if contentOffset.x >= widthPerCell * CGFloat(countOfCell+1){
            scrollView.contentOffset = CGPointMake(widthPerCell, 0)
        }
    }

}






