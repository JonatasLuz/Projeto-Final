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
    
    override func viewDidLoad() {
        
        loginViewModel = LoginViewModel()
        
        
        signIn.layer.cornerRadius = signIn.bounds.size.height / 2.5
        signUp.layer.cornerRadius = signUp.bounds.size.height / 2.5
        fbButton.heightAnchor.constraint(equalTo: signUp.heightAnchor).isActive = true
        fbButton.setTitle("Entre com o Facebook", for: [])
        fbButton.layer.cornerRadius =  fbButton.frame.size.height/2.5
        fbButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
    
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        logo.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func sigIn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email.text ?? "", password: password.text ?? "") { (authResult, error) in
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: email.text ?? "email", password: password.text ?? "") { (authResult, error) in
            guard (authResult?.user) != nil
                else {
                    print("Erro no cadastro:  \(String(describing: error))")
                    return
            }
        }
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
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                
                Auth.auth().signIn(with: credential, completion: { (result, error) in
                    if let error = error{
                        print(error)
                    }
                    else{
                        //self.loginViewModel.setUserInfo(Auth.auth().currentUser!.uid, Auth.auth().currentUser!.email!)
                        //self.loginViewModel.getUserData(completion: {
                       //       self.performSegue(withIdentifier: "loginAcepted", sender: self)
                        //})
                        
                        self.loginViewModel.getUser(Auth.auth().currentUser!.uid, Auth.auth().currentUser!.email!, completion: { (user) in
                            
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
}
