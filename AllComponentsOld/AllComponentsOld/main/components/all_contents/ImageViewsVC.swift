//
//  ImageViewsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit
import Alamofire
import PDFKit
import SwiftyGif

class ImageViewsVC: UIViewController {
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupImages()
    }
    
    func setupImages() {
        var offsetY: CGFloat = 20
        let imageViews: [(UIImageView, String)] = [
            (staticImage(), "Static Image"),
            (urlImage(), "URL PDF Image"),
            (alamofireImage(), "Alamofire GIF + Image Overlay")
        ]
        
        for (imageView, detail) in imageViews {
            imageView.frame = CGRect(x: 0, y: 0, width: imageScrollView.frame.width, height: 200)
            imageView.contentMode = .scaleAspectFit
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.yellow.cgColor
            imageView.frame.origin.y = offsetY
            imageScrollView.addSubview(imageView)
            
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.backgroundColor : UIColor.black,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.textEffect : NSAttributedString.TextEffectStyle.letterpressStyle
            ]
            let attributedString = NSAttributedString(string: detail, attributes: attributes)
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: imageView.frame.width - 20, height: 20))
            label.attributedText = attributedString
            label.text = detail
            label.textColor = .white
            label.textAlignment = .right
            imageView.addSubview(label)
            
            offsetY += imageView.frame.size.height + 20
        }
        imageScrollView.contentSize = CGSize(width: imageScrollView.frame.width, height: offsetY)
    }
    
    private func staticImage() -> UIImageView {
        let staticImageView = UIImageView()
        if let staticImage = UIImage(named: "logo_plain") {
            staticImageView.image = staticImage
        }
        return staticImageView
    }
    
    private func urlImage() -> UIImageView {
        let urlPDFView = UIImageView()
        DispatchQueue.global(qos: .background).async {
            if let pdfURL = URL(string: "https://filesamples.com/samples/document/pdf/sample1.pdf"),
               let pdfDocument = PDFDocument(url: pdfURL),
               let pdfPage = pdfDocument.page(at: 0) {
                if let pdfPageImage = self.imageFromPDFPage(pdfPage) {
                    DispatchQueue.main.async {
                        urlPDFView.image = pdfPageImage
                    }
                }
            }
        }
        return urlPDFView
    }
    
    private func alamofireImage() -> UIImageView {
        let alamofireImage = UIImageView()
        
        alamofireImage.contentMode = .scaleAspectFit
        AF.request("https://www.apple.com/newsroom/images/live-action/new-store-opening/Apple_Shinjuku_04042018_inline.gif").responseData { response in
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let gifImage = try? UIImage(gifData: data) {
                        print("Success: Received data is a valid GIF image")
                        alamofireImage.setGifImage(gifImage)
                        alamofireImage.startAnimatingGif()
                    } else {
                        print("Error: Received data is not a valid GIF image")
                    }
                }
            case .failure(let error):
                print("Error loading GIF image: \(error)")
            }
        }
        
        AF.request("https://raw.githubusercontent.com/Alamofire/Alamofire/master/Resources/AlamofireLogo.png").responseData { response in
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let staticImage = UIImage(data: data) {
                        print("Success: Received data is a valid Static image")
                        let staticImageView = UIImageView(image: staticImage)
                        staticImageView.contentMode = .scaleAspectFit
                        staticImageView.translatesAutoresizingMaskIntoConstraints = false
                        alamofireImage.addSubview(staticImageView)
                        
                        NSLayoutConstraint.activate([
                            staticImageView.topAnchor.constraint(equalTo: alamofireImage.topAnchor, constant: 4),
                            staticImageView.leadingAnchor.constraint(equalTo: alamofireImage.leadingAnchor, constant: 4),
                            staticImageView.widthAnchor.constraint(equalToConstant: 120),
                            staticImageView.heightAnchor.constraint(equalToConstant: 80)
                        ])
                    } else {
                        print("Error: Received data is not a valid Static image")
                    }
                }
            case .failure(let error):
                print("Error loading Static image: \(error)")
            }
        }
        return alamofireImage
    }
    
    private func imageFromPDFPage(_ page: PDFPage) -> UIImage? {
        guard let pageRef = page.pageRef else {
            return nil
        }
        let pageSize = page.bounds(for: .mediaBox).size
        let renderer = UIGraphicsImageRenderer(size: pageSize)
        let pdfImage = renderer.image { context in
            UIColor.white.set()
            context.fill(CGRect(origin: .zero, size: pageSize))
            context.cgContext.translateBy(x: 0.0, y: pageSize.height)
            context.cgContext.scaleBy(x: 1.0, y: -1.0)
            context.cgContext.drawPDFPage(pageRef)
        }
        return pdfImage
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
