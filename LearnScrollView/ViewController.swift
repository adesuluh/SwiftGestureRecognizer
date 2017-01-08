//
//  ViewController.swift
//  LearnScrollView
//
//  Created by Ade Suluh on 1/8/17.
//  Copyright © 2017 Ade Suluh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [UIImageView]()
    
    let maxPage = 2
    let minPage = 0
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var contentWidth: CGFloat = 0.0
        
        let scrollWidth = scrollView.frame.size.width
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            
            newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
            
            contentWidth += newX
            
            scrollView.addSubview(imageView)
            
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height/2) - 75, width: 150, height: 150)
        }
        
        self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
        
        scrollView.clipsToBounds = false
        
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveScrollView(direction: Int) {
        currentPage = currentPage + direction
        let point: CGPoint = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
    
        
         // Create a animation to increase the actual icon on screen
        UIView.animate(withDuration: 0.4) {
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            
             // Revert icon size of the non-active pages
            for x in 0..<self.images.count {
                if (x != self.currentPage) {
                     self.images[x].transform = CGAffineTransform.identity
                }
            }
        }
    }

    @IBAction func detectSwipe (_ sender: UISwipeGestureRecognizer) {
        if(currentPage < maxPage && sender.direction == UISwipeGestureRecognizerDirection.left) {
              moveScrollView(direction: 1)
        }
        if (currentPage > minPage && sender.direction == UISwipeGestureRecognizerDirection.right) {
            moveScrollView(direction: -1)
        }
    }
}
























