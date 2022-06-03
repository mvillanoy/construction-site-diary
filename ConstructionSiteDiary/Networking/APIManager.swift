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
        print(params)
 
        guard let url = try? URLRequest(url: type.url, method: type.httpMethod, headers: type.headers) else {return}

        AF.upload(multipartFormData: { (multipartFormData : MultipartFormData) in
            
            for (key, value) in params {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }

                    let count = images.count

                    for i in 0..<count{
                        multipartFormData.append(images[i].jpegData(compressionQuality: 0.8)!, withName: "image\(i)", fileName: "image\(i).jpeg", mimeType: "image/jpeg")

                    }

                    print(multipartFormData)
        }, to: type.url).response { (response) in
                    print(response)
                    switch response.result {
                    case .success(_):
                            handler(nil, nil)

                    case .failure(let encodingError):
                        print("failed")
                        print("\(encodingError.errorDescription)")
                        handler(nil, encodingError.errorDescription)

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
