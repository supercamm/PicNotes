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
    
    /*func findImage(_ imageName: String) -> String {
        var newImageName = imageName.lowercased()
        icon.image = UIImage(named: newImageName)
        
        if (icon.image == nil) {
            // nested if to handle s/es
            if (newImageName.characters.last == "s") {
                newImageName = String(newImageName.characters.dropLast())
                icon.image = UIImage(named: newImageName)
                
                if (newImageName.characters.last == "e" && icon.image == nil) {
                    newImageName = String(newImageName.characters.dropLast())
                    icon.image = UIImage(named: newImageName)
                }
            }
            // nested if to handle two word input - first word
            if (icon.image == nil && newImageName.components(separatedBy: " ").count > 1) {
                let first = newImageName.components(separatedBy: " ").first!
                let last = newImageName.components(separatedBy: " ").last!
                newImageName = first
                icon.image = UIImage(named: newImageName)
                
                // second word
                if (icon.image == nil) {
                    newImageName = last
                    icon.image = UIImage(named: newImageName)
                }
            }
            // default
            if (icon.image == nil) { newImageName = "no" }
        }
        return newImageName
    }*/
 
}
