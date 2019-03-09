//
//  CityDataLoader
//  TripAdvisor
//
//  Created by Xiaolu on 3/8/19.
//

import Foundation
import UIKit

//creat delegate for data change event. (maynot be useful for current workflow)
protocol CityDataManagerDelegate : class{
    func dataDidChange()
}

class  CityDataManager {
    static let shared = CityDataManager()
    private let networkManager = NetworkManager.shared
    
    //cache image
    private let cache = NSCache<NSString,UIImage>()
    private var cityList: [City]
    weak var delegate : CityDataManagerDelegate?
    
    private init(){
        cityList = [City]()
        loadDataFromFile()
    }
    
    func getCity(at index: Int) -> City?{
        guard cityList.count > index else {return nil}
        return cityList[index]
    }
    
    func getCityCount() -> Int{
        return cityList.count
    }
    
    func getImageForCity(_ city:City, _ completion : @escaping (Result<UIImage>) -> ()){
        guard let imageurl = city.imageURL else {
            completion(Result.failure)
            return
        }
        //get image from cache
        if let image = cache.object(forKey: imageurl as NSString){
            completion(Result.success(image))
        }else{
            //download image
            networkManager.downloadImage(urlString: imageurl) { [weak self] (result) in
                if case .success(let image) = result {
                    self?.cache.setObject(image, forKey: imageurl as NSString)
                    completion(result)
                }else{
                    completion(Result.failure)
                }
            }
        }
    }
    
    
    private func loadDataFromFile(){
        let filepath = Bundle.main.path(forResource: "city", ofType: "txt")
        do {
            let dataString: String! = try String(contentsOfFile: filepath!, encoding: .utf8)
            let lines: [String] = dataString.components(separatedBy: NSCharacterSet.newlines) as [String]
            for line in lines {
                var values: [String] = []
                if line != "" {
                    if line.range(of: "\"") != nil {
                        var textToScan:String = line
                        var value:NSString?
                        var textScanner:Scanner = Scanner(string: textToScan)
                        while textScanner.string != "" {
                            if (textScanner.string as NSString).substring(to: 1) == "\"" {
                                textScanner.scanLocation += 1
                                textScanner.scanUpTo("\"", into: &value)
                                textScanner.scanLocation += 1
                            } else {
                                textScanner.scanUpTo(",", into: &value)
                            }
                            
                            values.append(value! as String)
                            
                            if textScanner.scanLocation < textScanner.string.count {
                                textToScan = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
                            } else {
                                textToScan = ""
                            }
                            textScanner = Scanner(string: textToScan)
                        }
                    } else  {
                        values = line.components(separatedBy: ",")
                    }
                    cityList.append(City(values))
                }
            }
        } catch {
        }
        delegate?.dataDidChange()
    }
}


