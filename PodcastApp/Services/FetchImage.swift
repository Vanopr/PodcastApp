//
//  FetchImage.swift
//  PodcastApp
//
//  Created by Vanopr on 28.09.2023.
//

import Foundation
import UIKit

class FetchImage {
    
    //MARK: - Загрузка изображений
    
    static let shared = FetchImage()

       private let cache = NSCache<NSString, UIImage>()
    
       func loadImageFromURL(urlString: String, completion: @escaping (UIImage?) -> Void) {
           // Проверяем, есть ли изображение в кеше
           if let cachedImage = cache.object(forKey: urlString as NSString) {
               completion(cachedImage)
               return
           }

           guard let url = URL(string: urlString) else {
               completion(nil)
               return
           }

           URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
               guard let self = self, let data = data, error == nil else {
                   completion(nil)
                   return
               }

               if let image = UIImage(data: data) {
                   // Кэшируем изображение перед вызовом completion
                   self.cache.setObject(image, forKey: urlString as NSString)
                   completion(image)
               } else {
                   completion(nil)
               }
           }.resume()
       }


    
static func resizeImage(image: UIImage?, targetSize: CGSize) -> UIImage? {
        guard let image = image else {return nil}
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let scaleFactor = min(widthRatio, heightRatio)
        let scaledSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        UIGraphicsBeginImageContext(scaledSize)
        image.draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}
