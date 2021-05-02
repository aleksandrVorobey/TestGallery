//
//  NetworkDataFetcher.swift
//  TestGallery
//
//  Created by Александр Воробей on 03.05.2021.
//

import Foundation

class NetworkDataFetcher {
    
     func fetchImages() {
        guard let url = URL(string: "http://dev.bgsoft.biz/task/credits.json") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let fetchDictionary = try JSONDecoder().decode(GalleryDictionary.self, from: data)
                guard let dictionary = fetchDictionary else { return }
                for (key, value) in dictionary {
                    let galleryData = GalleryModel(imageURL: key, photoURL: value.photoURL, userURL: value.userURL, userName: value.userName)
                    print(galleryData)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
