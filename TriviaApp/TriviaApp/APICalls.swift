//
//  APICalls.swift
//  TriviaApp
//
//  Created by Muhammad Mubashir on 27/04/2023.
//

import Alamofire
import Foundation
import SwiftyJSON

class APICalls {
    class func fetchQuestions(queryItems: [URLQueryItem], completion: @escaping (Response?) -> ()) {
        let url = "https://opentdb.com/api.php"
        print(queryItems)
        
        var urlComps = URLComponents(string: url)!
        urlComps.queryItems = queryItems
        let result = urlComps.url!
        print(result)
        
        AF.request(result, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(_):
                do {
                    guard let data = response.data else { return completion(nil) }
                    let questions = try Response(data: data)
                    print(questions)
                    completion(questions)
                } catch {
                    print(error)
                    completion(nil)
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}

extension Decodable {
    init(data: Data, using decoder: JSONDecoder = .init()) throws {
        self = try decoder.decode(Self.self, from: data)
    }
    init(json: String, using decoder: JSONDecoder = .init()) throws {
        try self.init(data: Data(json.utf8), using: decoder)
    }
}

extension String {

    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }

}
