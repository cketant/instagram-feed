//
//  PhotoDetailsViewController.swift
//  
//
//  Created by christopher ketant on 10/13/16.
//
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    @IBOutlet weak var photoDetailView: UIImageView!
    var url: URL!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoDetailView.setImageWith(self.url, placeholderImage: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
