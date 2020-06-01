//
//  Network.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 31.05.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation
import Alamofire
import CryptoKit

class Network {
    
    static let shared = Network()
    let decoder = JSONDecoder()
    
    let publicKey: String = "21fed79d946a7e28edaf75bac3d29ec1"
    let privateKey: String = "eaee732c330519bcddf0850a9e351723f9c86b01"
    let ts = Date().timeIntervalSince1970.description
    
    
    let mainURL = "https://gateway.marvel.com/v1/public/"
    let characters = "characters"
    
    let limit = 30
    let comicsLimit = 10
    let startYear = "2005-01-01,"
    let date: String = Date().getDateString()

    
    func getCharacters(viewController: UIViewController, parameters: Parameters?, offset: Int?, completion: @escaping (_ success: Bool, ResultData?) -> Void){
        
        let authKey = getAuthKey()
        let offsetStr = String(offset ?? 0)
        let fullURL = URL(string: mainURL + characters + authKey)
        
        var params = Parameters.init()
        params["limit"] = limit
        params["offset"] = offsetStr
        
        self.requestWith(url: fullURL!, method: .get, parameters: params, viewController: viewController, showHud: true, showErrorAlerts: true, encoding: URLEncoding.queryString) { (response) in
            
            guard let data = response?.data else { return }
            do {
                let heroesResponse = try self.decoder.decode(ResultData.self, from: data)
                completion(true, heroesResponse)
            } catch let jsonError {
                print("Error serializing json.Network.characters:", jsonError)
                completion(false, nil)
            }
        }
    }
    
    func getComics(viewController: UIViewController, parameters: Parameters?, id: Int, completion: @escaping (_ success: Bool, ComicsResult?) -> Void){
        
        let authKey = getAuthKey()
        let idString: String = String(id)
        let fullURL = URL(string: mainURL + characters + "/" + idString + "/comics" + authKey )

        var params = Parameters.init()
        params["limit"] = comicsLimit
        params["dateRange"] = startYear + date
        params["orderBy"] = "-onsaleDate"
         
        
        self.requestWith(url: fullURL!, method: .get, parameters: params, viewController: viewController, showHud: true, showErrorAlerts: true, encoding: URLEncoding.queryString) { (response) in
            
            guard let data = response?.data else { return }
            do {
                let heroesResponse = try self.decoder.decode(ComicsResult.self, from: data)
                completion(true, heroesResponse)
            } catch let jsonError {
                print("Error serializing json.Network.characters:", jsonError)
                completion(false, nil)
            }
        }
    }
}

// MARK: RequestWith
extension Network {
    func requestWith(url: URL!, method: HTTPMethod, parameters: Parameters?, viewController: UIViewController, showHud: Bool, showErrorAlerts: Bool, encoding: ParameterEncoding, completionHandler: @escaping (_ response: DataResponse<Any>?) -> Void) {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: nil)
            .debugLog()
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                print(String(data: response.data!, encoding: .utf8) ?? "")
                
                
                switch response.result {
                    case .success:
                        completionHandler(response)
                    case .failure(let error):
                        if response.response?.statusCode == 401 {
                            print("Network.requestWith.error.Unauthorized:", error)
                            completionHandler(nil)
                        } else {
                            print("Network.requestWith.error:", error)
                            completionHandler(nil)
                    }
                }
        }
    }
}
// MARK: Request extension
extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint("================================================================================================")
        debugPrint(self)
        debugPrint("================================================================================================")
        #endif
        return self
    }
}
extension Network {

    public func getAuthKey() -> String{
        let hashFormat : String = "\(ts)\(privateKey)\(publicKey)"
        let hash = Insecure.MD5.hash(data: hashFormat.data(using: .utf8)!)

        let str = "\(hash)"
        let hashString = str.replacingOccurrences(of: "MD5 digest: ", with: "")
        let authKey : String = "?ts=\(ts)&apikey=\(publicKey)&hash=\(hashString)"
        return authKey
    }

}
