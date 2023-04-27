//
//  jsonModel.swift
//  TriviaApp
//
//  Created by Mac on 27/04/2023.
//

import Foundation

struct Response: Codable {
    let responseCode: Int
    var questions: [Question]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case questions = "results"
    }
}

// MARK: - Result
struct Question: Codable {
    let category: String
    let type: QuestionType
    let difficulty: Difficulty
    let question, correctAnswer: String
    let incorrectAnswers: [String]
    var isAttemptedCorrectly: Bool = false

    enum CodingKeys: String, CodingKey {
        case category, type, difficulty, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    func getOptions() -> [String] {
        var options = incorrectAnswers
        options.append(correctAnswer)
        return options.shuffled()
    }
}

enum Difficulty: String, Codable, CaseIterable {
    case any = "any"
    case easy = "easy"
    case medium = "medium"
    case difficult = "hard"
    
    var label: String? {
        switch self {
        case .any:
            return "Any Difficulty"
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .difficult:
            return "Hard"
        }
    }
}

enum QuestionType: String, Codable, CaseIterable {
    case any = "any"
    case multiple = "multiple"
    case bolean = "boolean"
    
    var label: String {
        switch self {
        case .any:
            return "Any Type"
        case .multiple:
            return "Multiple Choice"
        case .bolean:
            return "True/False"
        }
    }
}

func getDifficultyFromLabel(_ label: String) -> String {
    if label == "Easy" {
        return "easy"
    }
    else if label == "Medium" {
        return "medium"
    }
    else if label == "Hard" {
        return "hard"
    }
    else {
        return ""
    }
}

func getTypeFromLabel(_ label: String) -> String {
    if label == "Multiple Choice" {
        return "multiple"
    }
    else if label == "True/False" {
        return "boolean"
    }
    else {
        return ""
    }
}

func getCategoryFromLabel(_ label: String) -> String {
    let index = ["Any Category","General Knowledge","Entertainment: Books","Entertainment: Film","Entertainment: Music","Entertainment: Musicals & theatres","Entertainment: Television","Entertainment: Video Games","Entertainment: Board Games","Science & Nature","Science & Computer"].firstIndex{$0 == label}
    guard let index = index else { return "0"}
    return "\(index + 8)"
}
