//
//  LikeButton.swift
//  TwitterLikeButton
//
//  Created by 刘剑文 on 16/3/30.
//  Copyright © 2016年 kevinil. All rights reserved.
//

import UIKit

public protocol LikeButtonDelegate : NSObjectProtocol {
    func didSelectedLikeButton(likeButton: LikeButton)
    func didDeSelectedLikeButton(likeButton: LikeButton)
}

public class LikeButton: UIImageView {

    public var initialImg : UIImage? { didSet { self.image = initialImg } }
    public var selectedImg : UIImage?
    public var delegate : LikeButtonDelegate?
    
    var coverView : UIView!
    var uncoverView : UIView!
    var width : CGFloat!
    var height : CGFloat!
    var fx : CGFloat!
    var fy : CGFloat!
    
    var tap : UITapGestureRecognizer!
    var hasChosen = false
    
    var closeEight = [UIView]()
    var farEight = [UIView]()
    var rColors : [CGFloat] = [252, 224, 214, 240, 232, 144, 5]
    var gColors : [CGFloat] = [134, 81, 90, 78, 50, 252, 242]
    var bColors : [CGFloat] = [201, 162, 200, 108, 84, 81, 131]
    var wholeColors = [UIColor]()
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        createTwoViews()
        createColor()
        createEight()
        setupGesture()
        
        let bundle = NSBundle(forClass: LikeButton.self)
        let path0 = bundle.pathForResource("unlike", ofType: "png")
        let path1 = bundle.pathForResource("like", ofType: "png")
        self.image = UIImage(contentsOfFile: path0!)
        initialImg = UIImage(contentsOfFile: path0!)
        selectedImg = UIImage(contentsOfFile: path1!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTwoViews() {
        width = self.bounds.width
        height = self.bounds.height
        fx = self.frame.origin.x
        fy = self.frame.origin.y
        
        coverView = UIView(frame: CGRectMake(fx - width / 3, fy - height / 3, width * 5 / 3, height * 5 / 3))
        coverView.backgroundColor = UIColor(red: 204/255, green: 102/255, blue: 1, alpha: 1)
        coverView.layer.cornerRadius = coverView.bounds.width / 2
        coverView.hidden = true
        self.superview?.addSubview(coverView)
        print("super \(self.superview)")
        uncoverView = UIView(frame: coverView.frame)
        uncoverView.backgroundColor = UIColor.whiteColor()
        uncoverView.layer.cornerRadius = uncoverView.bounds.width / 2
        uncoverView.hidden = true
        self.superview?.addSubview(uncoverView)
    }
    
    override public func didMoveToSuperview() {
        self.superview?.addSubview(coverView)
        self.superview?.addSubview(uncoverView)
    }
    
    func setupGesture() {
        tap = UITapGestureRecognizer(target: self, action: #selector(LikeButton.tapDo))
        self.userInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    func tapDo() {
        hasChosen = !hasChosen
        if hasChosen {
            delegate?.didSelectedLikeButton(self)
            becomeLiked()
        }else {
            delegate?.didDeSelectedLikeButton(self)
            dislike()
        }
    }
    
    func createColor() {
        for index in 0..<7 {
            let color = UIColor(red: rColors[index]/255, green: gColors[index]/255, blue: bColors[index]/255, alpha: 1)
            wholeColors.append(color)
        }
    }
    
    func createEight() {
        let closesX = createPoints([-10, -4, -3 ,10, 17, 23, 25], type: .XT)
        let closesY = createPoints([10, -4, 23, -10, 22, -3, 17], type: .YT)
        doneEight(closesX, py: closesY, type: .Close)
        let farsX = createPoints([-13, -7 ,-6, 12, 15, 26, 28], type: .XT)
        let farsY = createPoints([7, -7, 26, -13, 25, -2, 19], type: .YT)
        doneEight(farsX, py: farsY, type: .Far)
    }
    
    func doneEight(px: [CGFloat], py: [CGFloat], type: EightType) {
        let bombSize = CGSizeMake(width * 3 / 20, height * 3 / 20)
        switch type {
        case .Close:
            for index in 0..<7 {
                let onePoint = CGPointMake(px[index], py[index])
                let colorView = UIView(frame: CGRect(origin: onePoint, size: bombSize))
                colorView.layer.cornerRadius = colorView.bounds.width / 2
                colorView.backgroundColor = wholeColors[index]
                closeEight.append(colorView)
            }
        case .Far :
            for index in 0..<7 {
                let onePoint = CGPointMake(px[index], py[index])
                let colorView = UIView(frame: CGRect(origin: onePoint, size: bombSize))
                colorView.layer.cornerRadius = colorView.bounds.width / 2
                colorView.backgroundColor = wholeColors[index]
                farEight.append(colorView)
            }
        }
    }
    
    enum EightType : Int {
        case Close, Far
    }
    
    enum PointType : Int {
        case XT, YT
    }
    
    func createPoints(ps: [CGFloat], type: PointType) -> [CGFloat] {
        var temps = [CGFloat]()
        switch type {
        case .XT :
            for p in ps { temps.append(rx(p)) }
        case .YT :
            for p in ps { temps.append(ry(p)) }
        }
        return temps
    }
    
    func rx(num: CGFloat) -> CGFloat {
        return fx + width * num / 20
    }
    
    func ry(num: CGFloat) -> CGFloat {
        return fy + height * num / 20
    }
    
    func becomeLiked() {
        uncoverView.layer.setAffineTransform(CGAffineTransformMakeScale(0.001, 0.001))
        uncoverView.layer.cornerRadius = uncoverView.bounds.width / 2
        uncoverView.hidden = false
        coverView.hidden = false
        loopAnimation()
        self.image = selectedImg
    }
    
    func dislike() {
        self.image = initialImg
        self.transform = CGAffineTransformMakeScale(1.5, 1.5)
        UIView.animateWithDuration(0.15) { () -> Void in
            self.self.transform = CGAffineTransformMakeScale(1, 1)
        }
    }
    
    func loopAnimation() {
        self.transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.animateWithDuration(0.12, animations: { () -> Void in
            self.uncoverView.transform = CGAffineTransformMakeScale(1, 1)
        }) { (finish) -> Void in
            self.uncoverView.hidden = true
            self.coverView.hidden = true
            self.showColorfulBalls()
            UIView.animateWithDuration(0.12, animations: { () -> Void in
                self.transform = CGAffineTransformMakeScale(1.2, 1.2)
            }) { (finish) -> Void in
                self.transform = CGAffineTransformMakeScale(1, 1)
                UIView.animateWithDuration(0.12, animations: { () -> Void in
                    
                    }, completion: { (finish) -> Void in
                        
                })
                
            }
        }
    }
    
    func showColorfulBalls() {
        UIView.animateWithDuration(0.15, animations: { () -> Void in
            for index in 0..<7 {
                self.superview!.addSubview(self.closeEight[index])
                self.superview!.addSubview(self.farEight[index])
                self.closeEight[index].alpha = 0.66
                self.closeEight[index].transform = CGAffineTransformMakeScale(0.5, 0.5)
            }
        }) { (finish) -> Void in
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                for index in 0..<7 {
                    
                    self.closeEight[index].alpha = 0.33
                    self.closeEight[index].transform = CGAffineTransformMakeScale(0.2, 0.2)
                    
                    self.farEight[index].alpha = 0.66
                    self.farEight[index].transform = CGAffineTransformMakeScale(0.5, 0.5)
                }
                }, completion: { (finish) -> Void in
                    UIView.animateWithDuration(0.15, animations: { () -> Void in
                        for index in 0..<7 {
                            self.closeEight[index].alpha = 0
                            self.closeEight[index].transform = CGAffineTransformMakeScale(0.01, 0.01)
                            self.farEight[index].alpha = 0.33
                            self.farEight[index].transform = CGAffineTransformMakeScale(0.2, 0.2)
                        }
                        }, completion: { (finish) -> Void in
                            UIView.animateWithDuration(0.15, animations: { () -> Void in
                                for index in 0..<7 {
                                    self.farEight[index].alpha = 0
                                    self.farEight[index].transform = CGAffineTransformMakeScale(0.01, 0.01)
                                }
                                }, completion: { (finish) -> Void in
                                    for index in 0..<7 {
                                        self.closeEight[index].removeFromSuperview()
                                        self.closeEight[index].transform = CGAffineTransformMakeScale(1, 1)
                                        self.closeEight[index].alpha = 1
                                        self.farEight[index].removeFromSuperview()
                                        self.farEight[index].transform = CGAffineTransformMakeScale(1, 1)
                                        self.farEight[index].alpha = 1
                                    }
                            })
                            
                    })
                    
            })
            
        }
    }


}
