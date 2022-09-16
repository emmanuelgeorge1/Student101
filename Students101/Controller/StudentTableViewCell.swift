//
//  StudentTableViewCell.swift
//  Students101
//
//  Created by Emmanuel George on 10/09/22.
//

import UIKit
import SwipeCellKit
class StudentTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    @IBOutlet weak var courseName: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: K.cellNibStudent, bundle: nil)
    }
    func configure(with imageName: String){
        studentImage.image = UIImage(systemName: imageName)
        studentImage.tintColor = .darkGray
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
