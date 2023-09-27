import UIKit

class ArcRingView: UIView {
    private var maskLayer = CAShapeLayer()

    var startAngle: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    var endAngle: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    var progress: CGFloat = 0.0 {
        didSet {
            animateProgress()
        }
    }

    var lineWidth: CGFloat = 35
    var gradientColors: [CGColor] = [UIColor(red: 196 / 255, green: 224 / 255, blue: 255 / 255, alpha: 1).cgColor, UIColor(red: 47 / 255, green: 145 / 255, blue: 255 / 255, alpha: 1).cgColor]

    func progressForCurrentAngle() -> CGFloat {
        let totalAngle = endAngle - startAngle
        let currentAngle = endAngle - startAngle
        let progress = 1.0 - (currentAngle / totalAngle)
        print(progress)
        return progress
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.sublayers?.removeAll()

        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - lineWidth / 2

        let startGradientPoint = CGPoint(x: 0.5 + 0.5 * cos(startAngle), y: 0.5 + 0.5 * sin(startAngle))
        let endGradientPoint = CGPoint(x: 0.5 + 0.5 * cos(endAngle), y: 0.5 + 0.5 * sin(endAngle))
 
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = startGradientPoint
        gradientLayer.endPoint = endGradientPoint
 
        let ringPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        maskLayer.path = ringPath.cgPath
        maskLayer.lineWidth = lineWidth
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = maskLayer

        layer.addSublayer(gradientLayer)
    }

    private func animateProgress() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = maskLayer.strokeEnd
        animation.toValue = progress
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        maskLayer.strokeEnd = progress
        maskLayer.add(animation, forKey: "animateProgress")
    }
}
