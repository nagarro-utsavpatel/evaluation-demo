//
//  MockEdmundsClient.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/2022.
//

import UIKit

struct MockEdmundsClient {
    private let session = URLSession.shared
    private let baseURL = URL(string: Constants.baseURL)!

    func getMakeList(completion: @escaping (Response<MakeModel>) -> Void) {
        log.info("Getting Mock data: SelectMake")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let jsonDecoder = JSONDecoder()
            let url = Bundle.main.url(forResource: "SelectMake", withExtension: "json")!
            let data = try? Data(contentsOf: url)
            let makeResponse = try? jsonDecoder.decode(Response<MakeModel>.self, from: data ?? Data())
            completion(makeResponse!)
        }
    }

    func getModelList(completion: @escaping (Response<Model>) -> Void) {
        log.info("Getting Mock data: SelectModel")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let jsonDecoder = JSONDecoder()
            let url = Bundle.main.url(forResource: "SelectModel", withExtension: "json")!
            let data = try? Data(contentsOf: url)
            let makeResponse = try? jsonDecoder.decode(Response<Model>.self, from: data ?? Data())
            completion(makeResponse!)
        }
    }

    func getModelStyle(completion: @escaping (Response<ModelStyles>) -> Void) {
        log.info("Getting Mock data: Styles")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let jsonDecoder = JSONDecoder()
            let url = Bundle.main.url(forResource: "ModelStyle", withExtension: "json")!
            let data = try? Data(contentsOf: url)
            let makeResponse = try? jsonDecoder.decode(Response<ModelStyles>.self, from: data ?? Data())
            completion(makeResponse!)
        }
    }
}
