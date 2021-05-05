//
//  ImageCell.swift
//  TestGallery
//
//  Created by Александр Воробей on 02.05.2021.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageGallery: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var photoURL: UITextView!
    @IBOutlet weak var nameURL: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoURL.isEditable = false
        nameURL.isEditable = false
        photoURL.isHidden = true
        nameURL.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageGallery.image = nil
        userNameLabel.text = nil
    }
    
    
    
    func configure(with urlString: String, userModel: GalleryModel) {
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: urlString), let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.imageGallery.image = UIImage(data: imageData)
                self.userNameLabel.text = userModel.userName
                
                let  stringPhotoURL = "PhotoURL"
                let atributPhotoURL = NSMutableAttributedString(string: stringPhotoURL, attributes: [NSAttributedString.Key.link: URL(string: userModel.photoURL)!])
                self.photoURL.attributedText = atributPhotoURL
                self.photoURL.isHidden = false
                
                let stringNameURL = "NameURL"
                let atributNameURL = NSMutableAttributedString(string: stringNameURL, attributes: [NSAttributedString.Key.link: URL(string: userModel.userURL)!])
                self.nameURL.attributedText = atributNameURL
                self.nameURL.isHidden = false
            }
        }
    }
}
