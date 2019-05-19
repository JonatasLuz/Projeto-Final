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
    override func viewDidLoad() {
        
        
        
        
        fbButton.setTitle("Entre com o Facebook", for: [])
        fbButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        //print(Auth.auth().currentUser?.uid)
        
        do{
            try Auth.auth().signOut()
        }catch{
            print("Error On signOut")
        }
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        logo.adjustsFontSizeToFitWidth = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //performSegue(withIdentifier: "loginAcepted", sender: self)
    }
    
    @IBAction func sigIn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email.text ?? "", password: password.text ?? "") { (authResult, error) in
        }
        print(Auth.auth().currentUser?.uid)
        
        print(Auth.auth().currentUser?.email)
        
        
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
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("sucesso")
                self.getUserData()
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                Auth.auth().signIn(with: credential, completion: { (result, error) in
                    if let error = error{
                        print(error)
                    }
                    else{
                        print("Sucess")
                    }
                })
            }
        }
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "loginAcepted", sender: self)
        }
    }
    func getUserData(){
        
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480)"])
        request.start(completionHandler: { (connection, result, error) -> Void in
            
            let teste = result as! NSDictionary
                print("getUserData")
                print(teste.value(forKey: "email"))
        })
    }
}
