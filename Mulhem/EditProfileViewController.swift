//
//  EditProfileViewController.swift
//  Mulhem
//
//  Created by Rania Alageel on 23/08/1444 AH.
//

import UIKit
import Firebase
import FirebaseFirestore


protocol EditprofileDelegate {
    func userUpdated(user: User)
}


//class EditProfileViewController: UIViewController , UITextFieldDelegate{
//
//    var userId = ""
//    let firestore = Firestore.firestore()
//
//
//    @IBOutlet weak var Uname: UITextField!
//    @IBOutlet weak var Uemail: UITextField!
//    @IBOutlet weak var Eval: UILabel!
//    @IBOutlet weak var Dval: UILabel!
//
//    var delegate : EditprofileDelegate!
//    var Lemail = ""
//    var CharacterName = ""
//
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
//
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        textField.resignFirstResponder()
//        return(true)
//    }
//    //touch out
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//    //return key
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if let id = Auth.auth().currentUser?.uid {
//            userId = id
//        }
//
//        firestore.collection("User").document(userId).getDocument { [self]snapshot, error in
//            if error == nil {
//                // get user data
//                guard let userData = snapshot else {return}
//                Uname.text = userData["name"] as? String
//                Uemail.text = userData["email"] as? String
//
//            } else {
//                // show error message
//            }
//        }
//
//    }
//
//    @IBAction func save(_ sender: Any) {
//
//        let validationResult = isValidR()
//                if validationResult.0 == false {return}
//
//                let validationResult2 = isValidName()
//                if validationResult2.0 == false {return}
//
//
//        let UserData : [String : Any] = ["name" : Uname.text, "email": Uemail.text]
//        firestore.collection("User").document(userId).updateData(childData) { [self] error in
//            if error == nil {
//                // update successfully
//                let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileViewController
//                profileVC.modalTransitionStyle = .crossDissolve
//                profileVC.modalPresentationStyle = .fullScreen
//                self.present(profileVC, animated: true)
//
//            } else {
//                // show error message
//            }
//        }
//    }
//
//
//    @IBAction func cancel(_ sender: Any) {
//
//        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! Profile
//        profileVC.modalTransitionStyle = .crossDissolve
//        profileVC.modalPresentationStyle = .fullScreen
//        self.present(profileVC, animated: true)
//    }
//
//    func isValidEmailR(emailID:String) -> Bool {
//           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//           return emailTest.evaluate(with: emailID)
//       }
//
//    func isValidR() -> (Bool, String, String) {
//
//           Eval.isHidden = true
//
//           guard let email = Uemail.text?.trimmingCharacters(in: .whitespaces).lowercased() , !email.isEmpty
//           else {
//               Eval.isHidden = false
//               Eval.text = "* الرجاء إدخال البريد الالكتروني"
//               return (false, "", "")
//           }
//
//           if !isValidEmailR(emailID: email) {
//               Eval.isHidden = false
//               Eval.text = "* الرجاء إدخال بريد الكتروني صحيح"
//               return (false, "", "")
//           }
//           return (true, email, "")
//       }
//
//    func isValidName() -> (Bool, String, String) {
//
//           guard let Name = Uname.text?.trimmingCharacters(in: .whitespaces).lowercased() , !Name.isEmpty
//           else {
//
//               Eval.isHidden = false
//               Eval.text = "* الرجاء إدخال اسم الشخصية"
//               return (false, "", "")
//              }
//           if !isValidCharacterName(nameText: Name) {
//               Eval.isHidden = false
//               Eval.text = "* الرجاء إدخال اسم شخصية صحيح"
//
//               return (false, "", "")
//           }
//           return (true, Name , "")
//       }
//
//
//    func isValidCharacterName(nameText:String) -> Bool {
//
//            let NameRegEx = "\\w{2,12}"
//            let NameTest = NSPredicate(format:"SELF MATCHES %@", NameRegEx)
//            return NameTest.evaluate(with: nameText)
//        }
//
//
//
//        func checkEmailExist(email: String, collection: String, field: String) async -> Bool {
//            let db = Firestore.firestore()
//            do {
//                let snapshot = try await db.collection(collection).whereField(field, isEqualTo: email).getDocuments()
//                print("COUNT ", snapshot.count)
//                print("not added")
//                return snapshot.count != 0
//            } catch {
//                print(error.localizedDescription)
//                print("added")
//                return false
//            }
//        }
//
//
//}
