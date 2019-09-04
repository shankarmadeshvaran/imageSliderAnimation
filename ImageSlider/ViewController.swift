//
//  ViewController.swift
//  ImageSlider
//
//  Created by User on 24/05/19.
//  Copyright © 2019 Heptagon. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    let images = [
        UIImage(named: "goku")!,
        UIImage(named: "goku1")!,
        UIImage(named: "goku2")
    ]
    
    var index = 0
    let animationDuration: TimeInterval = 0.25
    let switchingInterval: TimeInterval = 3
    var transition = CATransition()
    
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goToNextPage))
        
        imageView.image = images[index]
        animateImageView()
        index += 1
    }
    
    @objc func goToNextPage() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = mainStoryboard.instantiateViewController(withIdentifier: "AnimateLoginViewController") as? AnimateLoginViewController {
            present(controller, animated: true)
        }
    }
    
    func animateImageView() {
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.switchingInterval) {
                self.animateImageView()
            }
        }
        
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        /*
         transition.type = CATransitionType.fade
         transition.subtype = CATransitionSubtype.fromRight
         */
        
        imageView.layer.add(transition, forKey: kCATransition)
        if images.count != 0 {
            imageView.image = images[index]
        }
        CATransaction.commit()
        index = index < images.count - 1 ? index + 1 : 0
    }
}

