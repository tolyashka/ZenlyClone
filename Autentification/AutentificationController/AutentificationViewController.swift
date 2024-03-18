import UIKit

class AutentificationViewController: UIViewController {
    private lazy var hidingAnimation = HidingAnimation(forView: stackViewFields)
    // MARK: - Data logic
    private var autentificationMode: AutentificationType = .autentification {
        didSet {
            setValuesForElemets(withModel: autentificationModel, autentificationMode: autentificationMode)
        }
    }
    
    private var autentificationModel: AutentificationProtocol {
        let authorizationModel = AuthorizationModel()
        let registrationModel = RegistrationModel()
        return autentificationMode == .autentification ? authorizationModel : registrationModel
    }
    
    // MARK: - UI Components
    private lazy var headerAutentificationView = HeaderAutentificationView(autentificationModel: autentificationModel)
    
    private lazy var loginTextField = AutentificationTextField(autentificationModel: autentificationModel, type: .login)
    
    private lazy var emailTextField = AutentificationTextField(autentificationModel: autentificationModel, type: .email)
    
    private lazy var passwordTextField = AutentificationTextField(autentificationModel: autentificationModel, type: .password)
    
    private lazy var textFields = [loginTextField, emailTextField, passwordTextField]
    private lazy var stackViewFields = StackViewForFields(textFields: textFields)
    
    private lazy var autentificationButton = AutentificationButton(autentificationModel: autentificationModel, type: .autentification)
    
    private lazy var questionButton = AutentificationButton(autentificationModel: autentificationModel, type: .question)
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setAllLayoutConstraints()
        setValuesForElemets(withModel: autentificationModel, autentificationMode: .autentification)
        autentificationButton.addTarget(self, action: #selector(checkAutentificationAction), for: .touchUpInside)
        questionButton.addTarget(self, action: #selector(questionAction), for: .touchUpInside)
    }
    // MARK: - Buttons Actions
    @objc private func questionAction() {
        autentificationMode = autentificationMode.toggle()
        hidingAnimation.animate(withDuration: 1)
    }
    
    @objc private func checkAutentificationAction() {
        hidingAnimation.animate(withDuration: 1)
        let accountModel = AccountModel(login: loginTextField.text,
                                        email: emailTextField.text,
                                        password: passwordTextField.text)
        autentification(with: accountModel)
    }
    
    private func autentification(with accountModel: AccountModel) {
        let accountManager = AccountManager(accountModel: accountModel)
        print("------", accountManager)
        if autentificationMode == .autentification {
            accountManager?.authorization { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.navigationController?.pushViewController(TabBarController(), animated: true)
            }
        } else if autentificationMode == .question {
            accountManager?.createAccount()
        }
    }
    
    // - Change data method
    private func setValuesForElemets(withModel model: AutentificationProtocol, autentificationMode: AutentificationType) {
        headerAutentificationView.autentificationLabel.text = autentificationModel.autentificationLabel
        loginTextField.placeholder = model.loginPlaceholder
        emailTextField.placeholder = model.emailPlaceholder
        passwordTextField.placeholder = model.passwordPlaceholder
        autentificationButton.setTitle(model.authorizationButtonTitle, for: .normal)
        questionButton.setTitle(model.registrationButtonTitle, for: .normal)
        
        loginTextField.isHidden = autentificationMode == .autentification
    }
}

extension AutentificationViewController {
    private func setAllLayoutConstraints() {
    
        view.addSubview(headerAutentificationView)
        view.addSubview(stackViewFields)
        view.addSubview(autentificationButton)
        view.addSubview(questionButton)
        
        NSLayoutConstraint.activate([
            headerAutentificationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerAutentificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerAutentificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerAutentificationView.heightAnchor.constraint(equalToConstant: 175),
            
            stackViewFields.topAnchor.constraint(equalTo: headerAutentificationView.bottomAnchor, constant: 20),
            stackViewFields.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewFields.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 45),
            emailTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
            
            autentificationButton.topAnchor.constraint(equalTo: stackViewFields.bottomAnchor, constant: 35),
            autentificationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            autentificationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            autentificationButton.heightAnchor.constraint(equalToConstant: 45),
            
            questionButton.topAnchor.constraint(equalTo: autentificationButton.bottomAnchor, constant: 17),
            questionButton.leadingAnchor.constraint(equalTo: autentificationButton.leadingAnchor),
            questionButton.trailingAnchor.constraint(equalTo: autentificationButton.trailingAnchor),
            questionButton.heightAnchor.constraint(equalTo: autentificationButton.heightAnchor)
        ])
    }
}
