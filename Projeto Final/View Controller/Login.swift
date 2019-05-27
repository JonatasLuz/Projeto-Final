import UIKit
import Firebase
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit
class Login: UIViewController {
    
    @IBOutlet weak var logoView: UIView!
    
    
    @IBOutlet weak var logo: UILabel!
    
    @IBOutlet weak var fbButtonView: UIView!
    
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var fbButton: UIButton!
    
    var loginViewModel : LoginViewModel!
    
    var userLogin : User!
    var signUpView : UIView!
    var nameTextField : UITextField!
    var emailTextField : UITextField!
    var passwordTextField : UITextField!
    override func viewDidLoad() {
        
        loginViewModel = LoginViewModel()
   
        do{
            try Auth.auth().signOut()
        }catch{
            print(error)
        }
        print(Auth.auth().currentUser?.email)
        
        
        signIn.layer.cornerRadius = signIn.bounds.size.height / 2.5
        signUp.layer.cornerRadius = signUp.bounds.size.height / 2.5
        fbButton.heightAnchor.constraint(equalTo: signUp.heightAnchor).isActive = true
        fbButton.setTitle("Entre com o Facebook", for: [])
        fbButton.layer.cornerRadius =  fbButton.frame.size.height/2.5
        fbButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        let customViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        signUpView = UIView(frame: customViewFrame)
        signUpView.center = view.center
        signUpView.backgroundColor = UIColor(red:0.00, green:0.56, blue:0.32, alpha:1.0)
        
    
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        logo.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func sigIn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email.text ?? "", password: password.text ?? "") { (authResult, error) in
            if let error = error{
                self.alertError()
            }else{
                self.loginViewModel.getUser(Auth.auth().currentUser!.uid, "", "") { user in
                self.userLogin = user
                self.signUpView.removeFromSuperview()
                self.userLogin = user
                self.performSegue(withIdentifier: "loginAccepted", sender: self)
                }
            }
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        
        view.addSubview(signUpView)
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        nameLabel.text = "Nome"
        nameLabel.textColor = .white
        
        nameTextField = UITextField(frame: CGRect(x:35, y: signUpView.frame.height / 3, width: signUpView.frame.width - 70, height: 50))
        nameTextField.placeholder = "Nome"
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = nameTextField.frame.height / 4
        
        emailTextField = UITextField(frame: CGRect(x:35, y: signUpView.frame.height / 3 + 75, width: signUpView.frame.width - 70, height: 50))
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 4
        
        passwordTextField = UITextField(frame: CGRect(x:35, y: signUpView.frame.height / 3 + 150, width: signUpView.frame.width - 70, height: 50))
        passwordTextField.placeholder = "Senha"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 4

        signUpView.addSubview(passwordTextField)
        signUpView.addSubview(emailTextField)
        signUpView.addSubview(nameTextField)
        
        let signUpButton = UIButton(frame: CGRect(x:35, y: signUpView.frame.height / 3 + 225, width: signUpView.frame.width - 70, height: 50))
        //signUpButton.backgroundColor = .green
        signUpButton.setTitle("Cadastrar", for: [])
        signUpButton.setTitleColor(UIColor(red:0.00, green:0.56, blue:0.32, alpha:1.0), for: [])
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 4
        signUpButton.addTarget(self, action: #selector(signUpAction),for: .touchUpInside)
        
        let cancelButton = UIButton(frame: CGRect(x:35, y: signUpView.frame.height / 3 + 300, width: signUpView.frame.width - 70, height: 50))
        //cancelButton.backgroundColor = .gr
        cancelButton.setTitle("Cancelar", for: [])
        cancelButton.setTitleColor(.red, for: [])
        cancelButton.backgroundColor = .white
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 4
        cancelButton.addTarget(self, action: #selector(cancelAction),for: .touchUpInside)
        signUpView.addSubview(cancelButton)
        signUpView.addSubview(signUpButton)
    }
    
    @objc func signUpAction(){
        if nameTextField.text != ""{
            Auth.auth().createUser(withEmail: emailTextField.text ?? "email", password: passwordTextField.text ?? "") { (authResult, error) in
                guard (authResult?.user) != nil
                    else {
                        self.alertError()
                        return
                }
                self.loginViewModel.getUser(Auth.auth().currentUser!.uid, self.emailTextField.text!, self.nameTextField.text!) { user in
                    self.userLogin = user
                    self.signUpView.removeFromSuperview()
                    self.userLogin = user
                    self.performSegue(withIdentifier: "loginAccepted", sender: self)
                }
            }
        }else{
            self.alertError()
            return
        }
    }
    
    @objc func cancelAction(){
        signUpView.removeFromSuperview()

    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [ .publicProfile , .email ], viewController: self) { loginResult in
            let blankView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            blankView.frame = self.view.frame
            blankView.center = self.view.center
            blankView.backgroundColor = .white
            self.view.addSubview(blankView)
            let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
            
            activityIndicatorView.color = self.logo.textColor
            self.view.addSubview(activityIndicatorView)
            activityIndicatorView.center = self.view.center
            activityIndicatorView.frame = activityIndicatorView.frame
            activityIndicatorView.startAnimating()
            switch loginResult {
            case .failed(let error):
                self.alertError()
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                
                Auth.auth().signIn(with: credential, completion: { (result, error) in
                    if let error = error{
                        print(error)
                    }
                    else{
                        
                        print(Auth.auth().currentUser?.uid)
                        self.loginViewModel.getUser(Auth.auth().currentUser!.uid, Auth.auth().currentUser!.email!, "", completion: { (user) in
                            
                            self.userLogin = user
                            self.performSegue(withIdentifier: "loginAccepted", sender: self)
                        })
                    }
                    
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginAccepted"{
            if let navView = segue.destination as? UINavigationController{
                let next = navView.topViewController as! PlantsTableViewController
                next.user = userLogin
            }
        }
    }
    
    func alertError(){
        let alert = UIAlertController(title: "Erro", message: "Informações incorretas", preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in}
        alert.addAction(alertButton)
        self.present(alert,animated: true)
    }
}
