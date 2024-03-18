import UIKit

class HeaderAutentificationView: UIView {
    private var autentificationModel: AutentificationProtocol
    
    // MARK: Views
    private lazy var logotype: UIImageView = {
        let logotype = UIImageView()
        logotype.image = UIImage(named: autentificationModel.imageName)
        logotype.contentMode = .scaleAspectFit
        logotype.translatesAutoresizingMaskIntoConstraints = false
        return logotype
    }()
    private(set) lazy var autentificationLabel: UILabel = {
        let label = UILabel()
        label.text = autentificationModel.autentificationLabel
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var views = [logotype, autentificationLabel]
    
    // MARK: Initializatior
    public init(autentificationModel: AutentificationProtocol) {
        self.autentificationModel = autentificationModel
        super.init(frame: .zero)
        views.forEach({ self.addSubview($0) })
        setLayoutConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Constraints
    private func setLayoutConstraints() {
        let heightForLogotype: CGFloat = 100
        let widthForLogotype: CGFloat = 100
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logotype.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -35),
            logotype.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logotype.heightAnchor.constraint(equalToConstant: heightForLogotype),
            logotype.widthAnchor.constraint(equalToConstant: widthForLogotype),
            
            autentificationLabel.topAnchor.constraint(equalTo: logotype.bottomAnchor, constant: 25),
            autentificationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            autentificationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
        ])
    }
}
