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
        
        self.collectionView.isPagingEnabled = true
        self.collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
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
        print("Count: \(self.galleryModel.count)")
        return galleryModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let galleryModelItem = galleryModel[indexPath.item]
        cell.configure(with: "\(baseURL)\(galleryModelItem.imageURL).jpg", userName: galleryModelItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
