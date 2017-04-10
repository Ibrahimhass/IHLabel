//
//  ViewController.swift
//  numberLabel
//
//  Created by Md Ibrahim Hassan on 10/04/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
class myLabel: UILabel
{
    
    @IBInspectable
    public var animationInterval: Double = 1.0 {
        didSet {
//            self.layer.cornerRadius = self.cornerRadius
            let myDouble = NSNumber.init(value: animationInterval)
            let myTimeInterval = TimeInterval(myDouble.doubleValue)
            animLength = myTimeInterval
        }
    }
    
    @IBInspectable
    public var animationLimitTop: Double = 100.0 {
        didSet {
            //            self.layer.cornerRadius = self.cornerRadius
            let myDouble = NSNumber.init(value: animationLimitTop)
            animationLimit = myDouble
//            self.toLimit(limit: myDouble)
        }
    }
    
    
    
    private var displayLink : CADisplayLink?
    private var startTime = 0.0
    open var animLength = 1.0
    private var animationLimit: NSNumber = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print (animationLimit)
        print (animationInterval)
        self.toLimitWithDuration(limit: animationLimit, duration: animLength)
    }
    
    
    
    
    
    func toLimit(limit: NSNumber)
    {
        self.startDisplayLink()
    }
    func toLimitWithDuration(limit: NSNumber, duration: TimeInterval)
    {
        animLength = duration
        self.startDisplayLink()
    }
    func startDisplayLink() {
        
        // make sure to stop a previous running display link
        stopDisplayLink()
        
        // reset start time
        startTime = CACurrentMediaTime()
        
        // create displayLink & add it to the run-loop
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkDidFire))
        displayLink?.add(to: RunLoop.main, forMode: RunLoopMode(rawValue: RunLoopMode.commonModes.rawValue))
        
        // for Swift 2: displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode:NSDefaultRunLoopMode)
    }
    
    func displayLinkDidFire() {
        
        var elapsed = CACurrentMediaTime() - startTime
        
        if elapsed > animLength {
            stopDisplayLink()
            elapsed = animLength // clamp the elapsed time to the anim length
        }
        self.text = String((elapsed / animLength) * Double(animationLimit))
        // do your animation logic here
    }
    
    // invalidate display link if it's non-nil, then set to nil
    func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
}
