import UIKit

class AutentificationButton: UIButton {
    
    public enum ContextType {
        case autentification
        case question
    }
    
    private let autentificationModel: AutentificationProtocol
    private let type: ContextType
    
    public init(autentificationModel: AutentificationProtocol, type: ContextType) {
        self.autentificationModel = autentificationModel
        self.type = type
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch type {
        case .autentification:
            self.setTitle(autentificationModel.authorizationButtonTitle, for: .normal)
            self.backgroundColor = .systemBlue
            self.titleLabel?.font = .systemFont(ofSize: 20)
            self.setTitleColor(.white, for: .normal)
            self.layer.cornerRadius = 20
        case .question:
            self.setTitle(autentificationModel.registrationButtonTitle, for: .normal)
            self.titleLabel?.font = .systemFont(ofSize: 14)
            self.setTitleColor(.systemBlue, for: .normal)
        }
    }
}
