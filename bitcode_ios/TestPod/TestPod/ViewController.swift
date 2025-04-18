//
//  ViewController.swift
//  TestPod
//
//  Created by Deepak Kaligotla on 01/04/25.
//

import Kingfisher
import SDWebImage
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageUrl = URL(string: "https://picsum.photos/200/300")
        let gifUrl = URL(string: "https://www.apple.com/newsroom/images/product/app-store/Apple_App_Store_10th_anniversary_07102018_big.gif.large.gif")
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 20)
        imageView!.sd_setImage(
            with: gifUrl, placeholderImage: UIImage(systemName: "Star"))
        
        imageView2.kf.setImage(
            with: imageUrl,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage,
            ]
        ) { result in
            switch result {
            case .success(let value):
                print(
                    "Task done for: \(value.source.url?.absoluteString ?? "")"
                )
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
