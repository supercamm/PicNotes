//  TableViewCell.swift

import UIKit

class TableViewCell: UITableViewCell {
    
    // instance vars
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var ingredient: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellData(_ imageName: String, title: String) {
        icon.image = UIImage(named: findImage(imageName))
        ingredient.text = title
    }
    
    func findImage(_ imageName: String) -> String {
        let lowerName = imageName.lowercased()
        let nameArray = lowerName.components(separatedBy: " ")
        
        for name in nameArray {
            var word = name
            icon.image = UIImage(named: word)
            if (icon.image != nil) { return word }
            if (word.characters.last == "s") {
                word = String(word.characters.dropLast())
                
                icon.image = UIImage(named: word)
                
                if (icon.image == nil && word.characters.last == "e") {
                    word = String(word.characters.dropLast())
                    icon.image = UIImage(named: word)
                }
            }
            icon.image = UIImage(named: word)
            if (icon.image != nil) { return word }
        }
        return "no"
    } 
}
