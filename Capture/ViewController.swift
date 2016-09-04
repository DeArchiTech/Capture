//
//  ViewController.swift
//  Capture
//
//  Created by davix on 9/3/16.
//  Copyright © 2016 geniemedialabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var V1 : MainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        var V2 : SecondViewController = SecondViewController(nibName: "SecondViewController", bundle: nil)
        var V3 : ThirdViewController = ThirdViewController(nibName: "ThirdViewController", bundle: nil)
        
        self.addChildViewController(V1)
        self.scrollView.addSubview(V1.view)
        V1.didMoveToParentViewController(self)
        
        self.addChildViewController(V2)
        self.scrollView.addSubview(V2.view)
        V2.didMoveToParentViewController(self)
        
        self.addChildViewController(V3)
        self.scrollView.addSubview(V3.view)
        V3.didMoveToParentViewController(self)
        
        var V2Frame : CGRect = V2.view.frame
        V2Frame.origin.x = self.view.frame.width
        V2.view.frame = V2Frame
        
        var V3Frame : CGRect = V3.view.frame
        V3Frame.origin.x = 2 * self.view.frame.width
        V3.view.frame = V3Frame
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

