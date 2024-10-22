# DraggableProgressCircle 拿过去直接用吧！ 如果好用给个 Star ！
# 由于给的 UI 用第三方库很难实现，就自己写了一个。难点在于角度和弧度的计算，和拖动手势得处理。
#### GIF 示例 (不挂 VPN 查看不了 GIF)

<div style="display: flex; justify-content: space-between;">
  <img src="gif/fictitious.gif" marginTop="0" width="40%" height="40%"> 
  <img src="gif/reality.gif" width="40%" height="40%"> 
</div>

### 核心方法
角度转弧度和弧度计算！
```swift
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
```

## 如有问题或疑问，请通过电子邮件或 QQ 联系我！

##### If you have any questions or concerns, please contact me via email!

E-mail：matsonga@163.com
