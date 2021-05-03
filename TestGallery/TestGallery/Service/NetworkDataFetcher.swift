//
//  NetworkDataFetcher.swift
//  TestGallery
//
//  Created by Александр Воробей on 03.05.2021.
//

import Foundation

class NetworkDataFetcher {
    
    static func fetchImages(from url: String, completion: @escaping(GalleryDictionary)->()) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let fetchDictionary = try JSONDecoder().decode(GalleryDictionary.self, from: data)
                completion(fetchDictionary)
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
}
