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
        // Initialization code
    }
    
    func configure(with urlString: String) {
        guard let imageUrl = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, _, error) in
            guard let data = data,  error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageGallery.image = image
            }
        }
        task.resume()
    }

}
