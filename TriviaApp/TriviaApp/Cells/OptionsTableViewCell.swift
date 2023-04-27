//
//  OptionsTableViewCell.swift
//  TriviaApp
//
//  Created by Muhammad Mubashir on 27/04/2023.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var optionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(option: String) {
        borderView.layer.borderColor = UIColor(red: 136/255, green: 128/255, blue: 177/255, alpha: 1).cgColor
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = 5
        
        optionLabel.text = option
    }
}
