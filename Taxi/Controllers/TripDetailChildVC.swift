//
//  TripDetailChildVC.swift
//  Taxi
//
//  Created by Kuziboev Siddikjon on 12/22/21.
//

import UIKit

protocol TripDetailChildVCDelegate {
    func arrowBtnPressed()
}

class TripDetailChildVC: UIViewController {
    
    @IBOutlet weak var deleteDataBtn: UIButton! {
        didSet {
            deleteDataBtn.titleLabel?.font = UIFont.init(name: "Lato-Bold", size: 17)
        }
    }
    
    @IBOutlet var semi14: [UILabel]!
    
    @IBOutlet weak var lblTrips: UILabel!{
        didSet {
            lblTrips.font = UIFont.init(name: "Lato-Semibold", size: 14)
        }
    }
    @IBOutlet weak var lblRating: UILabel!{
        didSet {
            lblRating.font = UIFont.init(name: "Lato-Semibold", size: 14)
        }
    }
    
    @IBOutlet weak var lblDriverName: UILabel!{
        didSet {
            lblDriverName.font = UIFont.init(name: "Lato-Bold", size: 18)
        }
    }
    
    @IBOutlet  var black20: [UILabel]!{
        didSet {
            for i in black20 {
                i.font = UIFont.init(name: "Lato-Black", size: 20)
            }
        }
    }
    
    @IBOutlet var medium14: [UILabel]!{
        didSet {
            for i in medium14 {
                i.font = UIFont.init(name: "Lato-Medium", size: 14)
            }
        }
    }
    
    @IBOutlet var semi12: [UILabel]!{
        didSet {
            for i in semi12 {
                i.font = UIFont.init(name: "Lato-Semibold", size: 12)
            }
        }
    }
    
    @IBOutlet var bold14: [UILabel]!{
        didSet {
            for i in bold14 {
                i.font = UIFont.init(name: "Lato-Bold", size: 14)
            }
        }
    }
    
    
    
    
    @IBOutlet weak var arrowBtn: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
            
        }
    }
    
    @IBOutlet weak var carNumberContainerView: UIView!{
        didSet {
            carNumberContainerView.layer.borderWidth = 1
            carNumberContainerView.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
            carNumberContainerView.addShadow(offset: CGSize(width: 0, height: 4), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.01935471288), radius: 4, opacity: 1)
            carNumberContainerView.layer.cornerRadius = 6
        }
    }
    
    var viewSwiped : ((Bool) -> Void)?

    var delegate: TripDetailChildVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        containerView.addGestureRecognizer(gesture)
    }

    

  
    @IBAction func arrowBtnPressed(_ sender: Any) {
        delegate?.arrowBtnPressed()
    }
    
}

//MARK: Child
extension TripDetailChildVC {
    
    enum State {
        case partial
        case full
        case bottom
    }
    
    enum Constant {
        
        static var fullViewPosition: CGFloat = 30
        
        static var bottomPosition = UIScreen.main.bounds.height + 30
        
        static var partialViewPosition: CGFloat = UIScreen.main.bounds.height-270
        
    }
    
    
}

extension TripDetailChildVC{
    func moveView(state: State){
        
        let yPosition: CGFloat?
        if state == .partial {
            yPosition = Constant.partialViewPosition
        }else if state == .full {
            
            yPosition =  Constant.fullViewPosition
        }else {
            yPosition = Constant.bottomPosition
        }
        
        viewSwiped?(state == State.full)
        
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: yPosition ?? Constant.partialViewPosition, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: view)
        let minY = view.frame.minY
        if (minY + translation.y >= Constant.fullViewPosition) && (minY + translation.y <= Constant.partialViewPosition){
            view.frame = CGRect(x: 0, y: minY + translation.y, width: self.view.frame.width, height: self.view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer){
        NotificationCenter.default.post(name: NSNotification.Name("point"), object: Double(recognizer.translation(in: self.containerView).y))
        moveView(panGestureRecognizer: recognizer)
        
        if recognizer.state == .ended{
            UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction]) {
                let state : State = recognizer.velocity(in: self.view).y >= 0 ? .partial  : .full
                self.moveView(state: state)
            } completion: { _ in}
            
        }
    }
}

extension TripDetailChildVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollView.contentOffset.y < -90 {
            UIView.animate(withDuration: 0.3) {
                self.moveView(state: .partial)
            }
        }
    }
}
