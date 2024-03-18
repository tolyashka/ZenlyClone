import UIKit

class StackViewForFields: UIStackView {
    private let arrangedViews: [UITextField]
    
    init(textFields: [UITextField]) {
        self.arrangedViews = textFields
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 20
        self.contentMode = .center
        self.distribution = .equalCentering
        arrangedViews.forEach({ self.addArrangedSubview($0) })
    }
}
