import Foundation

enum AutentificationType {
    case autentification
    case question
    
    func toggle() -> AutentificationType {
        switch self {
        case .autentification: return .question
        case .question: return .autentification
        }
    }
}

protocol AutentificationProtocol {
    var autentificationLabel: String { get }
    var authorizationButtonTitle: String { get }
    var registrationButtonTitle: String { get }
    var loginPlaceholder: String { get }
    var emailPlaceholder: String { get }
    var passwordPlaceholder: String { get }
}
extension AutentificationProtocol {
    var imageName: String {
        return "Logotype"
    }
}

struct AuthorizationModel: AutentificationProtocol {
    let autentificationLabel = "Вход"
    let authorizationButtonTitle = "Войти"
    let registrationButtonTitle = "Нет аккаунта? Зарегистрировать аккаунт"
    let loginPlaceholder = "Введите логин"
    let emailPlaceholder = "Введите адрес электронной почты"
    let passwordPlaceholder = "Введите пароль"
}

struct RegistrationModel: AutentificationProtocol {
    var autentificationLabel = "Регистрация"
    var authorizationButtonTitle = "Регистрация"
    var registrationButtonTitle = "Уже есть аккаунт? Войти"
    var loginPlaceholder = "Придумайте логин"
    var emailPlaceholder = "Введите адрес электронной почты"
    var passwordPlaceholder = "Придумайте пароль"
}

