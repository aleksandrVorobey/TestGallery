//
//  ImageCell.swift
//  TestGallery
//
//  Created by Александр Воробей on 02.05.2021.
//

import UIKit

protocol ImageCellDelegate: class {
    func delete(cell: ImageCell)
}

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageGallery: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var photoURL: UITextView!
    @IBOutlet weak var nameURL: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: ImageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoURL.isEditable = false
        nameURL.isEditable = false
        photoURL.isHidden = true
        nameURL.isHidden = true
        deleteButton.isHidden = true
        imageGallery.layer.cornerRadius = 34
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageGallery.image = nil
        userNameLabel.text = nil
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    func shadow() {
        self.contentView.layer.cornerRadius = 34.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        self.layer.shadowRadius = 7.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
        func configure(with urlString: String, userModel: GalleryModel, cell: UICollectionViewCell) {
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
                self.deleteButton.isHidden = false
                
                self.shadow()
            }
        }
    }
}
