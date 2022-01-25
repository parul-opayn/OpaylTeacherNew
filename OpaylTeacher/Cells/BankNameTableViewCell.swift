//
//  BankNameTableViewCell.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 26/10/21.
//

import UIKit

class BankNameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var SeperatorLine: UIView!
    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    var isMultipleSelection =  false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if isMultipleSelection{
            if isSelected{
                checkBoxImage.image = UIImage(named: "checkBox")
            }
            else{
                checkBoxImage.image = UIImage(named: "uncheckBox")
            }
        }
        
    }
    
}
