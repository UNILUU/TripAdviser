//
//  ImageLoader.swift
//  TripAdvisor
//
//  Created by Xiaolu on 3/8/19.
//

import Foundation
import UIKit

enum Result<T> {
    case success(T);
    case failure;
}

class  NetworkManager {
    static let shared = NetworkManager()
    private let session = URLSession.shared
    
    private init(){
    }
    
    func downloadImage(urlString : String, completion: @escaping (_ result : Result<UIImage>) -> ()){
        guard let url = URL(string: urlString) else {
            completion(Result.failure)
            return
        }
        let task = session.dataTask(with: url) {(data, _, error) in
            guard let data = data, error == nil , let image = UIImage(data: data) else {
                 completion(Result.failure)
                return
            }
            DispatchQueue.main.async {
                completion(Result.success(image))
            }
        }
        task.resume()
    }
}


