//
//  ViewController.swift
//  logindemo
//
//  Created by user213309 on 2/4/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var Emailtext: UITextField!
  
    @IBOutlet weak var signButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        passwordtext.delegate = self
        Emailtext.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.Emailtext.resignFirstResponder()
        self.passwordtext.resignFirstResponder()
        return true
    }

    
    

    
    @IBAction func signin(_ sender: Any) {
        if(Emailtext.text == "root" && passwordtext.text == "root")
        {
            
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootVC = storyboard.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else {
                    print("ViewController not found")
                    return
                }
        
        
        self.navigationController?.pushViewController(rootVC, animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Wrong", message: "Wrong Credential", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
