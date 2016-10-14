//
//  ViewController.swift
//  Instagram
//
//  Created by christopher ketant on 10/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking


class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var postsDictionary: Array<NSDictionary> = []
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.rowHeight = 320
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    NSLog("response: \(responseDictionary)")
                    self.postsDictionary = (responseDictionary.value(forKeyPath: "response.posts") as? Array<NSDictionary>)!
                    self.tableView.reloadData()
                }
            }
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsDictionary.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoViewCellTableViewCell
        var post = self.postsDictionary[indexPath.row]
        var photoArray: Array<NSDictionary> = (post.object(forKey: "photos") as? Array<NSDictionary>)!
        var photo_dict: NSDictionary = photoArray[0] as! NSDictionary
        var url: URL = URL(string: photo_dict.value(forKeyPath: "original_size.url") as! String)!
        cell.photoView.setImageWith(url, placeholderImage: nil)
        return cell
    }

    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! PhotoDetailsViewController
        var indexPath = self.tableView.indexPath(for: sender as! UITableViewCell) as! IndexPath!
        
        var post = self.postsDictionary[(indexPath?.row)!]
        var photoArray: Array<NSDictionary> = (post.object(forKey: "photos") as? Array<NSDictionary>)!
        var photo_dict: NSDictionary = photoArray[0] as! NSDictionary
        var url: URL = URL(string: photo_dict.value(forKeyPath: "original_size.url") as! String)!
        
        vc.url = url
    }
}

