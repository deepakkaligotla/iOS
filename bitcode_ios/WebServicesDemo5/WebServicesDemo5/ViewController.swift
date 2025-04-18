import UIKit

class ViewController: UIViewController {
    private var url: URL!
    private var urlRequest: URLRequest?
    private var urlSession: URLSession?
    @IBOutlet weak var cartTableView: UITableView!
    private var extractedCarts: [Cart] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonSerialization()
        setupTableView()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        cartTableView.register(nib, forCellReuseIdentifier: "CartCell")
        cartTableView.dataSource = self
        cartTableView.delegate = self
    }
    
    private func jsonSerialization() {
        url = URL(string: Constants.urlString)!
        urlRequest = URLRequest(url: url)
        urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession!.dataTask(with: urlRequest!) { data, response, error in
            let apiResponse = try! JSONSerialization.jsonObject(with: data!) as! [String: Any]
            let extractingCarts = apiResponse["carts"] as! [[String: Any]]
            let total = apiResponse["total"] as! Int
            let skip = apiResponse["skip"] as! Int
            let limit = apiResponse["limit"] as! Int
            
            extractingCarts.forEach { cart in
                let extractingProducts = cart["products"] as! [[String: Any]]
                var products: [Product] = []
                extractingProducts.forEach { product in
                    products.append(Product(
                        productId: product["id"] as! Int,
                        productTitle: product["title"] as! String,
                        productPrice: product["price"] as! Double,
                        productQuantity: product["quantity"] as! Int,
                        productTotal: product["total"] as! Double,
                        productDiscountedPercentage: product["discountPercentage"] as! Double,
                        productDiscountedTotal: product["discountedTotal"] as! Double,
                        productImageUrl: product["thumbnail"] as! String))
                }
                self.extractedCarts.append(Cart(
                    cartId: cart["id"] as! Int,
                    products: products,
                    cartTotal: cart["total"] as! Double,
                    cartDiscountedTotal: cart["discountedTotal"] as! Double,
                    cartUserId: cart["userId"] as! Int,
                    cartTotalProducts: cart["totalProducts"] as! Int,
                    cartTotalQuantity: cart["totalQuantity"] as! Int))
            }
            print("\(total), \(skip), \(limit)")
            DispatchQueue.main.async {
                self.cartTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extractedCarts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
        let cart = extractedCarts[indexPath.row]
        cell.cartUserId.text = "User ID: \(cart.cartUserId)"
        cell.cartTotalProducts.text = "Items: \(cart.cartTotalProducts)"
        cell.cartTotalQuantity.text = "Quantity: \(cart.cartTotalQuantity)"
        cell.cartDiscountedTotal.text = "Discount: \(cart.cartDiscountedTotal)"
        cell.cartTotal.text = "Total: \(cart.cartTotal)"
        cell.products = cart.products
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 430
    }
}
