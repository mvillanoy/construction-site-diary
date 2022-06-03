//
//  APIManager.swift
//  ConstructionSiteDiary
//
//  Created by Monica Villanoy on 6/3/22.
//

import Alamofire

class AlertMessage {
    var title = "Error"
    var body = "Try submitting again later"
    
}

class ErrorObject: Codable {
    let message: String
    let key: String?
}


class APIManager {
    
    
    private let sessionManager: Session
    
    static let networkEnviroment: NetworkEnvironment = NetworkEnvironment.dev

    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(sessionManager: Session())
        return apiManager
    }()
    
    
    class func shared() -> APIManager {
        return sharedApiManager
    }
    
    private init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    
    
    func upload(type: EndPointType, params: Parameters, images: [UIImage] = [], handler: @escaping ((NSDictionary)?, _ error: String?)->()) {
 
        guard let url = try? URLRequest(url: type.url, method: type.httpMethod, headers: type.headers) else {return}

        AF.upload(multipartFormData: { (multipartData) in
                
                for i in 0 ..< images.count{
                    if let imageData = images[i].pngData(){
                        let mediaName = "media\(i + 1)"
                        multipartData.append(imageData, withName:mediaName, fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "file")
                    }
                }
              for (key, value) in params {
                    multipartData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to: url as! URLConvertible).responseJSON(queue: .main, options: .allowFragments) { (response) in
                switch response.result{
                case .success(_):
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: response.data! as Data,  options:JSONSerialization.ReadingOptions(rawValue: 0))
                        guard let JSONDictionary: NSDictionary = responseJSON as? NSDictionary else {
                            handler((nil), "Error in parsing")
                            return
                        }
                        handler((JSONDictionary), nil)
                    } catch {
                        handler((nil), "Error in parsing")
                    }
                case .failure(let error):
                    handler((nil), error.localizedDescription)
                }
            }
    }
    
    
    private func parseApiError(data: Data?) -> AlertMessage {
        let decoder = JSONDecoder()
        if let jsonData = data, let _ = try? decoder.decode(ErrorObject.self, from: jsonData) {
            return AlertMessage()
        }
        return AlertMessage()
    }
    
}
