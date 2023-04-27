//
//  ViewController.swift
//  TriviaApp
//
//  Created by Mac on 26/04/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LetsPalyButtonTapped(_ sender: Any) {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GenerateQuestionVC") as! GenerateQuestionVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}

