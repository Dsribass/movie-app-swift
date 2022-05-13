//
//  MovieSummaryTableViewCell.swift
//  App
//
//  Created by Daniel de Souza Ribas on 12/05/22.
//

import UIKit

class MovieSummaryTableViewCell: UITableViewCell {
    
    public static let identifier: String = "MovieSummaryTableViewCell"
    
    public static func getNib() -> UINib {
        let nib = UINib(nibName: identifier, bundle: nil)
        return nib
    }
    
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
