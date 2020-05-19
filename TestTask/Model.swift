//
//  Model.swift
//  TestTask
//
//  Created by Dima Bazhaniuk on 18.05.2020.
//  Copyright © 2020 Dima Bazhaniuk. All rights reserved.
//

import Foundation

struct Cats: Decodable {
    var id: String
    var name: String
    var description: String
}

struct Photo: Decodable {
    var id: String
    var url: String
   
    
}

var breedsData = [String]()
var image = [String]()
var desc = [String]()
var breedId = [String]()

//MARK: Functions for get data

func getCats(completion: @escaping () -> ()) {
    let urlString = "https://api.thecatapi.com/v1/breeds?attach_breed=0"
    let urlObj = URL(string: urlString)
    URLSession.shared.dataTask(with: urlObj!) { (data, response, error) in
        do {
            let names = try JSONDecoder().decode([Cats].self, from: data!)
            for i in names {
                breedsData.append(i.name)
                breedId.append(i.id)
                desc.append(i.description)
                print(breedsData)
                print(desc)
            }
            DispatchQueue.main.async {
                completion()
            }
        } catch {
            print(error)
        }
    }.resume()
}

func getPhoto(id: String, completion: @escaping () -> ()) {
    let url = "https://api.thecatapi.com/v1/images/search?breed_id=\(id)"
    let urlObj = URL(string: url)
    URLSession.shared.dataTask(with: urlObj!) { (data, response, error) in
        do {
            let names = try JSONDecoder().decode([Photo].self, from: data!)
            if names.first?.url != nil {
                image.removeAll()
                image.append(names.first!.url)
            }
            completion()
        } catch {
            print(error)
        }
    }.resume()
}






