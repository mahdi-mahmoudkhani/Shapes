//
//  ShapesTableVC.swift
//  Shapes
//
//  Created by Mahdi on 5/9/1403 AP.
//

import UIKit

class ShapesTableVC: UIViewController {

    var shapeNames: [String] = ["Square"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ShapesTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shapeNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShapesCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = shapeNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToShapesDetailVC", sender: nil)
    }
}
