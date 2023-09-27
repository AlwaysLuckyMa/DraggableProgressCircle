import UIKit

class DraggableProgressCircle: UIViewController {
    @IBOutlet var bgView: UIView!
    private var arcRingView: ArcRingView!
    private var bgViewView: ArcRingView!
    private var imageView: UIImageView!
    private let PI_ = (CGFloat.pi / 18)
    private let view_W = 230

    override func viewDidLoad() {
        super.viewDidLoad()

        bgView.addSubview({
            bgViewView = ArcRingView(frame: CGRect(x: 0, y: 0, width: view_WH, height: view_WH))
            bgViewView.backgroundColor = UIColor.clear
            bgViewView.lineWidth = 35
            bgViewView.endAngle = .pi * 2
            bgViewView.gradientColors = [rgba(231, 234, 238, 1).cgColor, rgba(231, 234, 238, 1).cgColor]
            return bgViewView
        }())

        bgView.addSubview({
            arcRingView = ArcRingView(frame: CGRect(x: 0, y: 0, width: view_W, height: view_W))
            arcRingView.backgroundColor = UIColor.clear
            arcRingView.lineWidth = 35
            arcRingView.startAngle = PI_ * 13.5
            arcRingView.endAngle = PI_ * 14.0
            return arcRingView
        }())

        bgView.addSubview({
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
            imageView.image = UIImage(named: "circleimg")
            imageView.center = CGPoint(x: arcRingView.frame.minX + imageView.frame.width / 2, y: arcRingView!.frame.maxY - arcRingView.frame.width / 2)
            imageView.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            imageView.addGestureRecognizer(panGesture)
            return imageView
        }())
    }

    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        switch gestureRecognizer.state {
        case .changed:
            let radius = view_W / 2 - 17.5
            let center = arcRingView.center
            let dx = imageView.center.x + translation.x - center.x
            let dy = imageView.center.y + translation.y - center.y
            let angle = atan2(dy, dx)

            imageView.center = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            arcRingView.endAngle = angle

            gestureRecognizer.setTranslation(.zero, in: view)
        default:
            break
        }
    }
}
