//
//  SummaryTVC.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 28.03.2021.
//
import UIKit

class SummaryTVC: UITableViewCell {
    static let identifier: String = "SummaryTVC"
    
    @IBOutlet weak var summaryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib()-> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    private func setupCell(){
        layer.backgroundColor = UIColor.black.cgColor
        layer.cornerRadius = 4
        summaryLabel.textColor = .darkGray
        
    }
    
    func configure(summaryLabel: String){
        self.summaryLabel.text = summaryLabel
    }
    
}
