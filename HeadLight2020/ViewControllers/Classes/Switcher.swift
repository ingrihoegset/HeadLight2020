

import UIKit
import CoreMotion

class Switcher: UIButton {

    var status: Bool = false {
        didSet {
            self.updatePosition()
        }
    }
    
    var backGroundShape: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "whiteTinted")
        view.layer.borderColor = UIColor(named: "accentLight")?.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = Constants.heightToggle / 2
        return view
    }()
    
    var toggleIndicatorOn: UIImageView = {
         let view = UIImageView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = UIColor(named: "mainColor")
         view.layer.cornerRadius = (Constants.heightToggle * 0.9) / 2
         view.image = UIImage(named: "ToggleOn")
         view.contentMode = .scaleAspectFill
         return view
    }()
    
    var toggleIndicatorOff: UIImageView = {
         let view = UIImageView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = .systemRed
         view.layer.cornerRadius = (Constants.heightToggle * 0.9) / 2
         view.image = UIImage(named: "ToggleOff")
         view.contentMode = .scaleAspectFill
         return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setStatus(true)
        self.addSubview(backGroundShape)
        self.addSubview(toggleIndicatorOn)
        self.addSubview(toggleIndicatorOff)
        toggleIndicatorOn.isHidden = false
        toggleIndicatorOff.isHidden = true
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePosition() {
        UIView.transition(with: self, duration: 0.10, options: .transitionCrossDissolve, animations: {
            if (self.status == true) {
                self.toggleIndicatorOn.isHidden = false
                self.toggleIndicatorOff.isHidden = true
            }
            else {
                self.toggleIndicatorOn.isHidden = true
                self.toggleIndicatorOff.isHidden = false
            }
        }, completion: nil)
    }
    
    func toggle() {
        if (self.status == true) {
            status = false
        }
        else {
            status = true
        }
    }
    
    func setStatus(_ status: Bool) {
        self.status = status
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.sendHapticFeedback()
        self.toggle()
    }
    
    func sendHapticFeedback() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .soft)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    func setConstraints() {
        backGroundShape.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backGroundShape.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backGroundShape.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backGroundShape.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        toggleIndicatorOn.centerYAnchor.constraint(equalTo: backGroundShape.centerYAnchor).isActive = true
        toggleIndicatorOn.widthAnchor.constraint(equalTo: backGroundShape.heightAnchor, multiplier:  0.9).isActive = true
        toggleIndicatorOn.trailingAnchor.constraint(equalTo: backGroundShape.trailingAnchor, constant: -2).isActive = true
        toggleIndicatorOn.heightAnchor.constraint(equalTo: backGroundShape.heightAnchor, multiplier: 0.9).isActive = true
        
        toggleIndicatorOff.centerYAnchor.constraint(equalTo: backGroundShape.centerYAnchor).isActive = true
        toggleIndicatorOff.widthAnchor.constraint(equalTo: backGroundShape.heightAnchor, multiplier:  0.9).isActive = true
        toggleIndicatorOff.leadingAnchor.constraint(equalTo: backGroundShape.leadingAnchor, constant: 2).isActive = true
        toggleIndicatorOff.heightAnchor.constraint(equalTo: backGroundShape.heightAnchor, multiplier: 0.9).isActive = true
    }    
}
