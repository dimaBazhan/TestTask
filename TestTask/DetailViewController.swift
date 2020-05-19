//
//  DetailViewController.swift
//  TestTask
//
//  Created by Dima Bazhaniuk on 19.05.2020.
//  Copyright © 2020 Dima Bazhaniuk. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageCats: UIImageView!
    @IBOutlet weak var discpLabel: UILabel!
    
    var dataOfDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discpLabel.text = dataOfDescription
        imageCats.downloaded(from: image.first!)
        
    }
    
}

//MARK: Exstantion for load image

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
