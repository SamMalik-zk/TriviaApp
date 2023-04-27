//
//  GenerateQuestionVC.swift
//  TriviaApp
//
//  Created by Mac on 26/04/2023.
//

import UIKit
import Alamofire
import iOSDropDown

class GenerateQuestionVC: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var selectTypeTxtField: DropDown!
    @IBOutlet weak var selectDifficultyTxtField: DropDown!
    @IBOutlet weak var selectCategoryTxtField: DropDown!
    @IBOutlet weak var numberOfQuestionDecrement: UIButton!
    @IBOutlet weak var numberOfQuestionIncrement: UIButton!
    @IBOutlet weak var numberOfQuestionLabel: UILabel!
    private var NumberOfQuestionIncrementLabel: Int = 1{
        didSet{
            numberOfQuestionLabel.text = "\(NumberOfQuestionIncrementLabel)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.layer.cornerRadius = 10
        selectCategoryTxtField.optionArray = ["Any Category","General Knowledge","Entertainment: Books","Entertainment: Film","Entertainment: Music","Entertainment: Musicals & theatres","Entertainment: Television","Entertainment: Video Games","Entertainment: Board Games","Science & Nature","Science & Computer"]
        selectCategoryTxtField.arrowSize = 10
        selectCategoryTxtField.selectedRowColor = .systemPurple
        selectCategoryTxtField.isSearchEnable = false
        selectDifficultyTxtField.optionArray = ["Any Difficulty","Easy","Medium","Hard"]
        selectDifficultyTxtField.selectedRowColor = .systemPurple
        selectDifficultyTxtField.isSearchEnable = false
        selectDifficultyTxtField.arrowSize = 10
        selectTypeTxtField.optionArray = ["Any Type","Multiple Choice", "True/False"]
        selectTypeTxtField.selectedRowColor = .systemPurple
        selectTypeTxtField.isSearchEnable = false
        selectTypeTxtField.arrowSize = 10
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numberOfQuestionDecrementTapped(_ sender: Any) {
        if(NumberOfQuestionIncrementLabel>1){
            NumberOfQuestionIncrementLabel -= 1
        }
    }
    
    @IBAction func numberOfQuestionIncrementTapped(_ sender: Any) {
        if(NumberOfQuestionIncrementLabel<50){
            NumberOfQuestionIncrementLabel += 1
        }
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        fetchQuestions()
    }
}

extension GenerateQuestionVC {
    
    private func fetchQuestions() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        var queryItems = [URLQueryItem]()
        if let amount = numberOfQuestionLabel.text {
            queryItems.append(URLQueryItem(name: "amount", value: amount))
        }
        if let category = selectCategoryTxtField.text, category != "Any Category" {
            queryItems.append(URLQueryItem(name: "category", value: getCategoryFromLabel(category)))
        }
        if let difficulty = selectDifficultyTxtField.text, difficulty != "Any Difficulty" {
            queryItems.append(URLQueryItem(name: "difficulty", value: getDifficultyFromLabel(difficulty)))
        }
        if let type = selectTypeTxtField.text, type != "Any Type" {
            queryItems.append(URLQueryItem(name: "type", value: getTypeFromLabel(type)))
        }
        
        APICalls.fetchQuestions(queryItems: queryItems) { [weak self] response in
            guard let self = self else { return }
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionnaireViewController") as! QuestionnaireViewController
            viewController.origResponse = response
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
