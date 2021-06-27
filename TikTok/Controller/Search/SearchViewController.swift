//
//  SearchViewController.swift
//  TikTok
//
//  Created by Imran on 28/3/21.
//

import UIKit

class SearchViewController: UIViewController {

    
    var searchSlider: SliderCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        searchSlider = SliderCollectionView()
        view.addSubview(searchSlider!)
        searchSlider?.position(top: view.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor,insets: .init(top: 60, left: 0, bottom: 0, right: 0 ))
        searchSlider?.size(height:160)
//        searchSlider?.backgroundColor = .yellow

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
