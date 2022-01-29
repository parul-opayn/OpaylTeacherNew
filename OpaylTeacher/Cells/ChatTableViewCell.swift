//
//  ChatTableViewCell.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 01/11/21.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundChatView: SetView!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var messageDateView: UIView!
    @IBOutlet weak var messageDateLbl: UILabel!
    @IBOutlet weak var messageTimeLbl: UILabel!
    @IBOutlet weak var usernameaLbl: UILabel!
    
    @IBOutlet weak var mediaImageView: UIImageView!
    
    var isRound = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
