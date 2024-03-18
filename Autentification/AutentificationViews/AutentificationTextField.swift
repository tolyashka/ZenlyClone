import UIKit

class AutentificationTextField: UITextField {
    
    // Type for context textField
    public enum ContextType {
        case login
        case email
        case password
    }
    
    private let type: ContextType
    private var autentificationModel: AutentificationProtocol
    
    // MARK: - Initializatiors
    public init(autentificationModel: AutentificationProtocol, type: ContextType) {
        self.type = type
        self.autentificationModel = autentificationModel
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup for self textField
    private func setupView() {
        self.borderStyle = .roundedRect
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
        self.textContentType = .oneTimeCode
        self.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.75)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.delegate = self
        switch type {
        case .login:
            self.placeholder = autentificationModel.loginPlaceholder
        case .email:
            self.placeholder = autentificationModel.emailPlaceholder
        case .password:
            self.isSecureTextEntry = true
            self.placeholder = autentificationModel.passwordPlaceholder
        }
    }
}
extension AutentificationTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
}
