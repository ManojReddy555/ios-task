//
//  DisplyViewController.swift
//  NewTask
//
//  Created by Manoj on 03/06/21.
//

import UIKit

class DisplyViewController: UIViewController {

    @IBOutlet weak var DImg: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    var dishesDetails:Category!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        display()
        

    }
    
    @IBAction func favorate(_ sender: UIButton) {
        print("My favorate food")
    }
    
    func display(){
        if dishesDetails == nil{
            print("error")
            
        }else{
        DispatchQueue.main.async {[self] in
        lbl1.text = "\(dishesDetails!.strCategory!)"
        lbl2.text = "\(dishesDetails!.strCategoryDescription!)"
            }
        let posters = URLRequest(url: URL(string: "\(dishesDetails!.strCategoryThumb!)")!)
            let posterObj = URLSession.shared.dataTask(with: posters) { (data, response, error) in
                DispatchQueue.main.async { [self] in
                    DImg.image = UIImage(data: data!)
                }
                
            }
            posterObj.resume()
        }
        
    }



}
