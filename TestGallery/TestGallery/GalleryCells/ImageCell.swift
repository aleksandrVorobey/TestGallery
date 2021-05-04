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
        guard let imageUrl = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, _, error) in
            guard let data = data,  error == nil else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.imageGallery.image = image
                self?.userNameLabel.text = userName.userName
            }
        }
        task.resume()
    }

}
