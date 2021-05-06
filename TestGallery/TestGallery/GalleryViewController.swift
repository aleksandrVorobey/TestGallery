//
//  GalleryViewController.swift
//  TestGallery
//
//  Created by Александр Воробей on 02.05.2021.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let url = "http://dev.bgsoft.biz/task/credits.json"
    private let baseURL = "http://dev.bgsoft.biz/task/"
    var galleryModel = [GalleryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        carousel()
        
        self.collectionView.isPagingEnabled = true
        self.collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func carousel() {
        let floawLayaout = UPCarouselFlowLayout()
        floawLayaout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height)
        floawLayaout.scrollDirection = .horizontal
        floawLayaout.sideItemScale = 0.8
        floawLayaout.sideItemAlpha = 1.0
        floawLayaout.spacingMode = .fixed(spacing: 5.0)
        collectionView.collectionViewLayout = floawLayaout
    }
    
    func fetchData() {
        NetworkDataFetcher.fetchImages(from: url) { (dataDictionary) in
                guard let data = dataDictionary else { return }
                for (key, value) in data {
                    let galleryModel = GalleryModel(imageURL: key, photoURL: value.photoURL, userURL: value.userURL, userName: value.userName)
                    self.galleryModel.append(galleryModel)
                    self.galleryModel = self.galleryModel.sorted {$0.userName < $1.userName}
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
            }
        }
    }
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let galleryModelItem = galleryModel[indexPath.item]
        cell.configure(with: "\(baseURL)\(galleryModelItem.imageURL).jpg", userModel: galleryModelItem, cell: cell)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

extension GalleryViewController: ImageCellDelegate {
    func delete(cell: ImageCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            galleryModel.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
        }
    }

}
