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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageGallery.image = nil
        userNameLabel.text = nil
    }
    
    func configure(with urlString: String, userName: GalleryModel) {
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: urlString), let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.imageGallery.image = UIImage(data: imageData)
                self.userNameLabel.text = userName.userName
            }
        }
    }
}
