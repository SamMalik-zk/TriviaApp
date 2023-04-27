//
//  QuestionnaireViewController.swift
//  TriviaApp
//
//  Created by Mac on 27/04/2023.
//

import UIKit

class QuestionnaireViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    
    var origResponse: Response?
    private var response: Response? {
        didSet {
            question = response?.questions.first
            options = question?.getOptions() ?? []
        }
    }
    private var question: Question?
    private var options: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        response = origResponse
        setupUI()
    }
    
    private func setupUI() {
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.reloadData()
        
        questionLabel.text = String(htmlEncodedString: question?.question ?? "")
    }
}

extension QuestionnaireViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionsTableViewCell
        let option = options[indexPath.row]
        cell.setupCell(option: option)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = origResponse?.questions.firstIndex{$0.question == response?.questions.first?.question}
        guard let index = index else { return }
        origResponse?.questions[index].isAttemptedCorrectly = (response?.questions.first?.correctAnswer == options[indexPath.row])
        response?.questions.removeFirst()
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { return }
            self.setupUI()
        }
        guard (response?.questions.count == 0) else { return }
        questionLabel.textAlignment = .center
        let correctAnswers = origResponse?.questions.filter{$0.isAttemptedCorrectly}.count ?? 0
        questionLabel.text = "Correct answers: \(correctAnswers)"
    }
}
