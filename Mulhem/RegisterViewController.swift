//
//  RegisterViewController.swift
//  Mulhem
//
//  Created by Rania Alageel on 22/08/1444 AH.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CoreMedia



class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var Emailvalidation: UILabel!
    @IBOutlet weak var Passwordvalidation: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var Namevalidation: UILabel!
    @IBOutlet weak var CreateAccountButton: UIButton!
   

    
    
    var Name = ""
    var Lemail = ""
    var Lpassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
   
        emailTextField.text = Global.shared.useremailshare
        passwordTextField.text = Global.shared.userpasswordshare
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.resignFirstResponder()
        return(true)
    }
    //touch out
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func isValidR() -> (Bool, String, String) {
        Emailvalidation.isHidden = true
        Passwordvalidation.isHidden = true
        
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces).lowercased() , !email.isEmpty
        else {
            Emailvalidation.isHidden = false
            Emailvalidation.text = "* الرجاء إدخال البريد الالكتروني"
            return (false, "", "")
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            Passwordvalidation.isHidden = false
            Passwordvalidation.text = "* الرجاء إدخال كلمة المرور"
            return (false, "", "")
        }
        if !isValidEmailR(emailID: email) {
            Emailvalidation.isHidden = false
            Emailvalidation.text = "* الرجاء إدخال بريد الكتروني صحيح"
            return (false, "", "")
        }
        if !isValidPasswordR(PasswordText: password){
         
            Passwordvalidation.isHidden = false
            Passwordvalidation.text = "* الرجاء إدخال كلمة مرور بين ٨ و ١٥ رقم"
            return (false, "", "")
        }
        return (true, email, password)
    }

    
    @IBAction func CreateAccountButton(_ sender: UIButton) {
        
        
        self.tabBarController?.tabBar.isHidden = true
        Emailvalidation.isHidden = true
        Passwordvalidation.isHidden = true
//        self.emailTextField.delegate = self
//        self.passwordTextField.delegate = self
        Namevalidation.isHidden = true
        

//        EmailAndPassCheck()
     
        let validationResult = isValidR()
        if validationResult.0 == false {return}

        let email = validationResult.1
        let password = validationResult.2

        print("email : " , email)
        print("password : " , password)


        Global.shared.useremailshare = email
        Global.shared.userpasswordshare = password
        Auth.auth().signIn(withEmail: email, password: password) { authResult , error in
                      if let e = error {
                        print("not exists email 111")
                         }else {
                             print("email exists")
                             self.Emailvalidation.isHidden = false
                             self.Emailvalidation.text = "*هذا البريد الالكتروني موجود"

                }
        }
        
//        NameCheck()
        
        let validationResult2 = isValidName()
        if validationResult2.0 == false {return}

        let name = validationResult2.1

        Name = name
        Global.shared.usercharacterName = name
        print("CharacterName : " , Name)


        print("Global email : " , Global.shared.useremailshare )
        print("Global password : ", Global.shared.userpasswordshare )
        print("Global  name : " , Global.shared.usercharacterName)


        Auth.auth().createUser(withEmail: Global.shared.useremailshare, password: Global.shared.userpasswordshare) { authResult , error in
            guard let userId  = authResult?.user.uid else {return}
            self.storeUserInformation(id: userId)
            if let e = error {
            print(e.localizedDescription)
            }else {
             // Go to our home screen
             self.performSegue(withIdentifier: "goToHomePage", sender: self)
           }
        }
        
    }// func
    
    
    
    func EmailAndPassCheck(){
       
        let validationResult = isValidR()
        if validationResult.0 == false {return}
        
        let email = validationResult.1
        let password = validationResult.2
        
        print("email : " , email)
        print("password : " , password)
        
        
        Global.shared.useremailshare = email
        Global.shared.userpasswordshare = password
        Auth.auth().signIn(withEmail: email, password: password) { authResult , error in
                      if let e = error {
                        print("not exists email")
                         }else {
                             print("email exists")
                             self.Emailvalidation.isHidden = false
                             self.Emailvalidation.text = "*هذا البريد الالكتروني موجود"
                            
                }
        }
        
    }
    
    func NameCheck(){
        
        let validationResult2 = isValidName()
        if validationResult2.0 == false {return}

        let name = validationResult2.1

        Name = name
        Global.shared.usercharacterName = name
        print("CharacterName : " , Name)
 
 
        print("Global email : " , Global.shared.useremailshare )
        print("Global password : ", Global.shared.userpasswordshare )
        print("Global  name : " , Global.shared.usercharacterName)
  
        
        
        Auth.auth().createUser(withEmail: Global.shared.useremailshare, password: Global.shared.userpasswordshare) { authResult , error in
            guard let userId  = authResult?.user.uid else {return}
            self.storeUserInformation(id: userId)
        if let e = error {
        print(e.localizedDescription)
        }else {
        // Go to our home screen
        self.performSegue(withIdentifier: "goToHomePage", sender: self)
           }
        }
 
       
        
  }
    
    
    
    
    func isValidEmailR(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isValidPasswordR(PasswordText:String) -> Bool {
        let passwordRegEx = ".{8,15}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: PasswordText)
    }
    
    
    
    
    
    func checkEmailExist(email: String, collection: String, field: String) async -> Bool {
        let db = Firestore.firestore()
        do {
            let snapshot = try await db.collection(collection).whereField(field, isEqualTo: email).getDocuments()
            print("COUNT ", snapshot.count)
            print("not added")
            return snapshot.count != 0
        } catch {
            print(error.localizedDescription)
            print("added")
            return false
        }
    }
    
    
    
    func isValidName() -> (Bool, String, String) {
        
        guard let Name = nameTextField.text?.trimmingCharacters(in: .whitespaces).lowercased() , !Name.isEmpty
        else {
            Namevalidation.isHidden = false
            Namevalidation.text = "* الرجاء إدخال اسم "
            return (false, "", "")
           }
        if !isValidCharacterName(nameText: Name) {
            Namevalidation.isHidden = false
            Namevalidation.text = "* الرجاء إدخال اسم صحيح"
            return (false, "", "")
        }
        return (true, Name , "")
    }
    
    
    func isValidCharacterName(nameText:String) -> Bool {
        
        let NameRegEx = "\\w{2,12}"
        let NameTest = NSPredicate(format:"SELF MATCHES %@", NameRegEx)
        return NameTest.evaluate(with: nameText)
    }
    
    
    
    func storeUserInformation(id: String)  {
            
            let post = ["email": Global.shared.useremailshare,
                        "password": Global.shared.userpasswordshare,
                        "name": Global.shared.usercharacterName,
            ] as [String : Any]
            let db = Firestore.firestore()
                   do {
                    try db.collection("User").document(id).setData(post)
                   } catch {
                       print(error.localizedDescription)
                   }
        print("add the user into the firebafe firestore")
        }
    
    

}
