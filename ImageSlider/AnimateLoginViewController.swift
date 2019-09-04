//
//  AnimateLoginViewController.swift
//  ImageSlider
//
//  Created by User on 27/05/19.
//  Copyright © 2019 Heptagon. All rights reserved.
//

import UIKit

class AnimateLoginViewController: UIViewController {
    
    @IBOutlet weak var MainScrollView: UIScrollView!
    
    var scrollImageTimer: Timer!
    
    let images = ["goku","goku1","goku2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollableBackground()
        setTimer()
    }
    
    func setTimer() {
        scrollImageTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }
    
    func setScrollableBackground() {
        self.MainScrollView.frame = self.view.frame
        self.MainScrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.MainScrollView.frame.width
        let scrollViewHeight:CGFloat = self.MainScrollView.frame.height
        
        for index in 0..<images.count {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
            imageView.image = UIImage(named: images[index])
            imageView.contentMode = .scaleAspectFit
            
            self.MainScrollView.addSubview(imageView)
        }
        
        /*
        let firstGokuImage = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        firstGokuImage.image = UIImage(named: "goku")
        firstGokuImage.contentMode = .scaleAspectFit
        
        let secondGokuImage = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        secondGokuImage.image = UIImage(named: "goku1")
        secondGokuImage.contentMode = .scaleAspectFit
        
        let thirdGokuImage = UIImageView(frame: CGRect(x:scrollViewWidth * 2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        thirdGokuImage.image = UIImage(named: "goku2")
        thirdGokuImage.contentMode = .scaleAspectFit
        
        self.MainScrollView.addSubview(firstGokuImage)
        self.MainScrollView.addSubview(secondGokuImage)
        self.MainScrollView.addSubview(thirdGokuImage)
        */
        
        self.MainScrollView.contentSize = CGSize(width:self.MainScrollView.frame.width * CGFloat(images.count), height: self.MainScrollView.frame.height)
    }
    
    @objc func moveToNextPage() {
        let pageWidth:CGFloat = self.MainScrollView.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat(images.count)
        let contentOffset:CGFloat = self.MainScrollView.contentOffset.x
        var slideToX = contentOffset + pageWidth
        if  contentOffset + pageWidth == maxWidth {
            slideToX = 0
        }
        self.MainScrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.MainScrollView.frame.height), animated: true)
    }
    
}
