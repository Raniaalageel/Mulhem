//
//  ProfileViewController.swift
//  Mulhem
//
//  Created by Rania Alageel on 23/08/1444 AH.
//

import UIKit
//import AudioToolbox
//import CodableFirebase
//import Firebase
//import FirebaseFirestore


//class ProfileViewController: UIViewController, EditprofileDelegate {
//
//        func userUpdated(user: User) {
//            name.text = user.name
//            email.text = user.email
//        }
//
//
//        @IBOutlet weak var email: UILabel!
//        @IBOutlet weak var name: UILabel!
//        let firestore = Firestore.firestore()
//        var emaill : String?
//        var user : User?
//        var userId = ""
//
//
//    @IBAction func logouut(_ sender: UIButton) {
//    }
//
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
//            if let id = Auth.auth().currentUser?.uid {
//                userId = id
//            }
//
//
//            firestore.collection("User").document(userId).getDocument { [self]snapshot, error in
//                if error == nil {
//                    // get user data
//                    guard let userData = snapshot else {return}
//                    user = User(email: userData["email"] as? String, name: userData["name"] as? String)
//                    name.text = userData["name"] as? String
//                    email.text = userData["email"] as? String
//
//                } else {
//                    // show error message
//                }
//            }
//        }
//
//
//
//        @IBAction func logoutButton(_ sender: UIButton) {
//
//            print("pressed")
//            print("logout")
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//            let alertVC = storyboard.instantiateViewController(withIdentifier: "logoutPorfile") as! logoutPorfile
//            present(alertVC, animated: true)
//      }
//
// }
