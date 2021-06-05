//
//  TVC.swift
//  NewTask
//
//  Created by Manoj on 03/06/21.
//

import UIKit

class TVC: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var FAVBtn: UIButton!
    
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        
        // Initialization code
    }

    
    @IBAction func favorite(_ sender: UIButton) {
        print("myFavorate")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
