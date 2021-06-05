//
//  TVCViewController.swift
//  NewTask
//
//  Created by Manoj on 03/06/21.
//

import UIKit

class TVCViewController: UITableViewController, UISearchBarDelegate,UISearchControllerDelegate{
    
//  Properties
    var urlReq:URLRequest!
    var dataTaskObj:URLSessionDataTask!
    var convertedData:DetailCategories!
    var searchController = UISearchController(searchResultsController: nil)
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
//      function Disply
        getDataFromServer()
        searchBarSetUp()
    }
    private func datamodelSetUp(){
        convertedData.categories?.compactMap({ (Category) -> String in
            if "id" == Category.idCategory{
                
                return Category.idCategory!
            }
            return Category.idCategory!
        })
    }
//    Search Bar Function
    private func searchBarSetUp(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if convertedData != nil{
            return convertedData.categories!.count
        }
        return 0
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TVC = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TVC
        if convertedData == nil{
            print("Error")
        }else{
            cell.lbl.text = "\(convertedData.categories![indexPath.row].strCategory!)"
            let posters = URLRequest(url: URL(string: "\(convertedData.categories![indexPath.row].strCategoryThumb!)")!)
            let posterObj = URLSession.shared.dataTask(with: posters) { (data, res, err) in
                DispatchQueue.main.async {
                    cell.img.image = UIImage(data: data!)
                }
            }
            posterObj.resume()
        }
        cell.lbl.numberOfLines = 0
    
        return cell
    }
//    Movie to cell to Another Controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayViewController = (storyboard?.instantiateViewController(identifier: "displayViewController"))! as DisplyViewController
        displayViewController.dishesDetails = convertedData!.categories![indexPath.row]
       navigationController?.pushViewController(displayViewController, animated: true)
        
    }

    
    // Override to support conditional editing of the table view.
  /*  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TVCViewController{
    
    func getDataFromServer(){
        urlReq = URLRequest(url:URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!)
        dataTaskObj = URLSession.shared.dataTask(with: urlReq, completionHandler: { [self] (data, response, error) in
            print("Get Data From Server")
            print(data!)
            if error == nil{
                
            do{
                let JsonDecoder = JSONDecoder()
                 convertedData = try
                    JsonDecoder.decode(DetailCategories.self, from: data!)
            DispatchQueue.main.async {
                  tableView.reloadData()
            }
            }catch
            {
                print("Something Went Wrong")
                
            }
            }else{
                print(error!.localizedDescription)
            }
        })
        //Connecting To Server
        dataTaskObj.resume()
    }
    
    
}
// Search Bar controller
extension TVCViewController:UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {

        guard let searchText = searchController.searchBar.text else {
            return
        }
        if searchText == ""{
            datamodelSetUp()
        }else{
            
            
            
       tableView.reloadData()
    }
   
}
    

}
