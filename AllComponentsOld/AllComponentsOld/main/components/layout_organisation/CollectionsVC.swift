//
//  CollectionsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit

class CollectionsVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectedItem: UILabel!
    
    let sections: [String] = ["Home", "TV Shows", "Movies", "New & Popular", "My List", "Browse by Languages"]
    let data: [[(name: String, url: String)]] = [
        [(name: "Home", url: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/LmEnxtiAuzezXBjYXPuDgfZ4zZQ/AAAABQFvJDeMk5NtHJyBd5Y_zrGgI94_DMLHDh-_YsSQl8Ma5aSypVJTEaJpwR_U4J0_znCwrTdNIuOGrgfj1mqn3RkLek83choBhnFAYkvgzM8n.png?r=be7")],
        [(name: "Baby Reindeer", url: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/Qs00mKCpRvrkl3HZAN5KwEL1kpE/AAAABZfou4FGLvysbb1b7UPRg9J3K0N9QnCqwrypEtWuuO6x9g1mMFoex1l7JG15Q0P91zuE6dyt1mJO2T2TY6kL923h5NukmO74QSvc2X_TECS5-yp16B9hrmt2EJ1383zO5_AVzgyU2uJXAdC9Go9aukDfWUcgyvmp462wno10DnRqv1OPFaZw-_zzfzdvFXaiOkJlOX5e4qY-VthaYdJx3FiskNMZnLjO6ClZEBhjm0vlj5cRqr1W4q5UZU-_YS6s_w7F-VSqKQq_JKR1LypeCtylL0N4-Sf0T0r6GikyYV68fiDs3c7o2v5rjiDgqUzolhU93MVlONJEPcgAEdpRovjC3WUHAx58nY2g3YErtaBzmibdw73k.webp?r=3ac"), (name: "Dead Boy Detectives", url: "https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQasBZNEfDq803BbbWX0ZzoVs-hC2Tg7ETR2htqOCeMoXtjfjwsjUx1jIPnVJkVB04eRPkAMa_xtOk9cVnahBBtR4sjCPTKpxmeJjyS9P356zdzUkIGLrhu5K4nqAJOUP-03G2OIHayD9VdPpSWoApm-Z.jpg?r=9a1"), (name: "Unlocked: A Jail Experiment", url: "https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQXYCZg6XpGmCMtDBqwSEnhA18LJ9TYp6TNdRF_-FhLPwrp3eWJBJqBVx-ZyC-5pqBPKeMM6NyGJ4K9qHhpIwJl8CZdYmuH1zDg0qIunyCPB7ut3oK_863iM258R9CzdzCgP-MwYBkkJZXS8miR6F2peZ.jpg?r=1cf"), (name: "CoComelon Lane", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJAiraVKKhWxnyUrI6e7M09tdOaB7WlJJuGQcxgznALg&s"), (name: "The Gentlemen", url: "https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQSdPtOy7VRb2_knpJOxxHPsKEM0kGofNcVvLhhC608ptK9TIlWK0OSI1OxRuwUbY9bUUIHXnx4YK6Hvy_tTvNQtYgSQKHtNCMMxwGPfAy-n1uD4ehe4rtZ7xZ_TKNPunrK6JlOHZmumarzFGAMV9-_BX.jpg?r=7d6"), (name: "3 Body Problem", url: "https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQZlc5jetJ-D7HB82kd0QKhDPoQtVo0ez6AgsRBt7WnoqCe1NMdjNxuZPe5fQVeMXvQAvlZTQwo5NL_M2xhpfNikQkyynm0hjIpAEJ63kaCMD7tpb7DE2GyspOeL_u8idcYLvtb0c6_XMzHCqScBJNLW6.jpg?r=c4c"), (name: "Our Living World", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQV8Krea9pPJ2urMTJt8hPFXfZr0awTx-n1gI_EI-Xi-w&s"), (name: "The Circle", url: "https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQb8mFJH0YWVM8XGuRgBxpAZ3p7-0YnyZ6jqxyyq40fmo1uRBR8zL3_Fh0_J2M7Cr_DQu_E0pSNIdoQYBHbSpz-wIxWtDEQ4dPS_U9aWo7p_Ylk-eAgYuCpgGKVxqcUksmbWKgMrdz_ZO0jsyVts5LSeE.jpg?r=a81"), (name: "Heartbreak High", url: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/WNk1mr9x_Cd_2itp6pUM7-lXMJg/AAAABW2maR-SvwbN6erg--7DvrFcnJZhAxbhDi0978MXUMBasRcajBNiClIRMctPuzoDXmTethF9ev1ZcwDVZRGiGVbs_R6Nio7HZbEu5AYeoDubTM_6IyDexznK9k9jBVdAs0kOAJNbZyigEtRovFTBa3LKqYoq4qcuJe47SDD6WXWE5BkIndY9XJF5KDAV6DBsTvSJwWhUiqGhad0ksetTWro832UYEp-uFIjn6CF69aVlAvTSXXZc24cTBhHOxCycp0P0ZOIWgMgfyzyt8lByEnJvb173Grb9q9cfVxuIoiY97lnarBA.webp?r=024"), (name: "Bad Dinosaurs", url: "https://dnm.nflximg.net/api/v6/WNk1mr9x_Cd_2itp6pUM7-lXMJg/AAAABTnXqksH3Y_rZV15Kvs_J_Rk_JFKb47ZUThVpna7-slE0sqsvB6v4pFR_b4ah4uP1iXY-qfEXXWtKwQknCPWjHovfk8d4SpZr9ZtGhUa6akpMz351yP3IrDgmtofMQ6gKZ6zLQ.jpg?r=06b")],
        [(name: "Rebel Moon — Part Two: The Scargiver", url: "https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQbz91TRPlUKenCiAKpi4G9PN66fdeE3TGe4AArLbO7edNsNzvQHjBV-PMWkJBIX__cDRbY34_JbsGU7nyNsxiB8sPowF2T4caRk0TzB_EJ9ylDXkjMJ2hvV4dEARKWdWipLXsfBqbqYu2RjqmVASAk0vjHw.jpg"), (name: "Anyone But You", url: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/Qs00mKCpRvrkl3HZAN5KwEL1kpE/AAAABXlbBHiwIapV7HgyYHsY2nNQybRsOxju6YRMYj6WxoUmR9q-z2pB25inQAWC2obDBVuu302hRxAoydcGb3U-2lx6JhYvhFfdE9M0jRAUStLb-dMeMcYK1fIHDIcb4NgIt_V1RAeJHZaT2vQv05UiMQ5Y2C0EqZXrlREyJTT9QXyrVlPOCnxooV03UWzp9CIubd22iuGofaEn6H_jZfNTIJVZDHtWe1EhcRnuRUQL_8JMEc-x1hjLq4sltvxGBmDtfqobO2BNxKhhS15N173ZlGg-ZjOe_APPyloMKIF51TqJTm76ODpcSGZ4cHr9CGyBMtoIf_VR_jLbw2ACh-fdoNFg.webp?r=b9f"), (name: "Woody Woodpecker Goes to Camp", url: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABYU7139iFky2exXOgxjsUpu0GIdmF4Z9fBhssWUXUb7OpoyTKk036MVAQX3kDCpTnAUmUUnlS-vz-h2Sxwxb0UM9LjrFKavOEQV8.jpg?r=953"), (name: "Rebel Moon — Part One: A Child of Fire", url: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/6gmvu2hxdfnQ55LZZjyzYR4kzGk/AAAABbI9sgbvR-mgbFdvkFQMbTXrluhvbuSNygoMTO2RIA5s2EJEJ9XTCUaufAu5z2wgPixJz4dGdcmJ77YXQOwu10stm1bTq5nVj44ctgyeCs9sLXahHLHPQd_Qrw0nWpuoEaXvoVjDkcl2ZsWraTepvkq41sGYQWIQCodBj4YDKqnJa4FxaprfEpvVHjBlBK2QzAHDlLeAb2Ts9T9NOUfbQ9Y7fYghAamm_ZEo2IAjZmO0B6xKroSWH3mf9I5iwBDWozBrPQLgC82n9KBshX7v-bzrB3GI6cNLPQqyiffmbFPq9y2P199nDR_Fng.jpg?r=7c8"), (name: "What Jennifer Did", url: "https://dnm.nflximg.net/api/v6/ALnfVbMvPhqZAIuQMLkxmdJcXYk/AAAAQfd6N-HuA5b0-WvdpCfM6OQ9M2hE22vSbYU5b_aKB2C_4P7GXmkF_liHfxe9msNJfMhAkTONbbQDspNfmamr3AB3iEJF7Z1VAed2JX32_TMzfq4gnJXcSE-S-JTzSOVc2Atq1OZO1wClJ82AiyMlHykJMGzNgVMRYUHpbhTIHfcRIAKLAqwRoxQStsy8Wy6G2NF7TgxqmuzVTZnILSMCbei6_MJpq8VjUHg4UNg_-oJlinqBI_-N8KKsDW5alHl7lYj7KOoWGuqKKMr32w.jpg?r=510"), (name: "Hack Your Health: The Secrets of Your Gut", url: "https://dnm.nflximg.net/api/v6/WNk1mr9x_Cd_2itp6pUM7-lXMJg/AAAABXyip5WPag4vxPPlEaGDSchm1yJG5fMX8ZE0VNujNwkF-QSPbPU5zA24vVXZmmdvL8hByHAb2PA2p-_NyG6VpFXbHIfq-wv_Pf8PvDFFqbkeZCZ0pNLwjgXd0XwjmN2xuzGS7g.jpg?r=4d4"), (name: "Smurfs: The Lost Village", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9mSgFiSKEz8JFS_uvcfvtjN5o0EVq90JZWAvYUooVzw&s"), (name: "Lifemark", url: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/Qs00mKCpRvrkl3HZAN5KwEL1kpE/AAAABXWDemOHpi44rmyvXA59Zufa22RaeK8FBA4kBm1DwaIkvgswpETrmF0OpmAIPu11WhF_novtloLXfnXfdefgopUU2X51icKGsv3bplrFuRo0QqLk69RIcE1-8-J-t-GkY2LsIvuB5qR9V7ZYCX3uxMcptBduIzaqisZYS2BXWU771zct1UB-sFD4ftDSB7AyFm3qbjSkdSgseE4K5UN8a4ncbpecA6tl9wWGx1BpqSZzMFwJWsccLcavqJGVbxnREp9bMO5FwkTaBALBX7bmaiPOyZeee-HkEwkuWQqpX3OpBCM0vcW0gLM4Sz_WsTM9ZS9qSWB2R86uGM3TY_Z97j4.jpg?r=f5b"), (name: "Hotel Mumbai", url: "https://dnm.nflximg.net/api/v6/WNk1mr9x_Cd_2itp6pUM7-lXMJg/AAAABXpeFKNZIIcgEizajMidGtsOpv2fuGaHpBzYtQdblPHkABlgcw8L1Z9vzwI8pm4zkCkHL_AFnwuapy5udhXlzD3TnxGDT-8yZZph.jpg?r=2bd"), (name: "Glass", url: "https://occ-0-2794-2219.1.nflxso.net/dnm/api/v6/Qs00mKCpRvrkl3HZAN5KwEL1kpE/AAAABbQvg9fYtHpaGhTB1OzKCFm0fp23w3Wfq1QPUwZX-txR3BvGXLZ9OFotnvyByuXaYlThL7wzvzlT_1NrDfWjABCg45tV6nqueSDhAJXAS37cRT3zMQVsoJ2jYO2ryxAF1StY720sg62NrT-W5-isQy3_eQC16PtXqEqx3euQ0fL3Yy7J5Ueb2gdbDAFhggNu_tus_tRRQj48xS-2n4-MesdnOJ8jAT_i74m4qs8BXf1EI4oYV3bE4BhBxGUkKLyABo8gaheWApEi2Md3Ba0bcJPGVpiEXw.jpg?r=2ec")],
        [(name: "New & Popular", url: "https://www.netflix.com/tudum/top10/social/social-en.jpg")],
        [(name: "My List", url: "https://techcrunch.com/wp-content/uploads/2023/05/image-1-2.png")],
        [(name: "Select your choice", url:"https://images.indianexpress.com/2022/01/Netflix-change-language-2.jpg")]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let customHomeCVLayout = UICollectionViewFlowLayout()
        customHomeCVLayout.minimumInteritemSpacing = 5
        customHomeCVLayout.minimumLineSpacing = 5
        customHomeCVLayout.sectionInset = .zero
        self.collectionView.collectionViewLayout = customHomeCVLayout
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension CollectionsVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionVcell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CVCReusable", for: indexPath) as! CollectionsVCell
        URLSession.shared.dataTask(with: URL(string: self.data[indexPath.section][indexPath.row].url)!) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch image:", error?.localizedDescription ?? "Unknown error")
                return
            }
            DispatchQueue.main.async {
                collectionVcell.setup(dataTitle: self.data[indexPath.section][indexPath.row].name, with: UIImage(data: data)!)
            }
        }.resume()
        return collectionVcell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionVSH = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CSHReusable", for: indexPath) as! CollectionsSH
        collectionVSH.setup(with: self.sections[indexPath.section])
        return collectionVSH
    }
}

extension CollectionsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.selectedItem.text = self.data[indexPath.section][indexPath.row].name
        }
    }
}

extension CollectionsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 140, height: 200)
    }
}

class CollectionsSH: UICollectionReusableView {
    @IBOutlet weak var sectionHead: UILabel!
    
    func setup(with title: String) {
        self.sectionHead.text = title
    }
}

class CollectionsVCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dataTitle: UILabel!
    
    func setup(dataTitle:String, with image: UIImage) {
        self.dataTitle.text = dataTitle
        self.imageView.image = image
        self.imageView.contentMode = .scaleAspectFit
    }
}
