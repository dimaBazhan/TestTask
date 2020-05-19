//
//  ViewController.swift
//  TestTask
//
//  Created by Dima Bazhaniuk on 18.05.2020.
//  Copyright © 2020 Dima Bazhaniuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataToSend = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
      
        getCats {
            self.tableView.reloadData()
        }
        
    }
    
    //MARK: tableView delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return breedsData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
            cell.textLabel?.text = breedsData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        view.endEditing(true)
        self.dataToSend = desc[indexPath.row]
        getPhoto(id: breedId[indexPath.row], completion: {
            print(image)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "show", sender: nil)
            }
        })
        
    }
    
    //MARK: Pass data to detailViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
            let vc = segue.destination as? DetailViewController
            vc?.dataOfDescription = dataToSend
        }
    }

}


