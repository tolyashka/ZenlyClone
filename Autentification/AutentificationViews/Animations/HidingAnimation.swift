import UIKit

class HidingAnimation: UIView {
    
    private let hidingView: UIView
    
    public init(forView view: UIView) {
        self.hidingView = view
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(withDuration duration: Double) {
        UIView.animate(withDuration: duration) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.hidingView.alpha = 0.25
            strongSelf.hidingView.alpha = 1
        }
    }
}
