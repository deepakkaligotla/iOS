//
//  Models.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 09/08/24.
//

import Foundation

struct Country {
    let name: String
    let code: String
    let flag: String
}

struct SignInRequest {
    let email: String
    let password: String
    let deviceToken: String
    let userType: String
}

struct SignInResponse: Decodable {
    let status: String
    let message: String
    let data: SignInData
    
    struct SignInData: Decodable {
        let token: String
    }
}

struct UserResponse: Decodable {
    let users: [User]
    let meta: Meta
    
    struct User: Decodable {
        let firstName: String
        let lastName: String
        let fullName: String
        let email: String
        let password: String
        let userType: String
        let terminal: String
    }
    
    struct Meta: Decodable {
        let total: Int
        let page: Int
        let limit: Int
    }
}

struct DiagnosticAndMalfunctionEvent: Codable {
    var driver: String
    var truck: String
    var location: String
    var event: String
    var date: String
    var time: String
}

final class APIConfig {
    static let baseUrl: String = "https://2520cb2a-d32b-4d84-b0b5-bbf3aa38bf71.mock.pstmn.io"
}

let countries: [Country] = [
    Country(name: "Afghanistan", code: "AFG", flag: "🇦🇫"),
    Country(name: "Albania", code: "ALB", flag: "🇦🇱"),
    Country(name: "Algeria", code: "DZA", flag: "🇩🇿"),
    Country(name: "Andorra", code: "AND", flag: "🇦🇩"),
    Country(name: "Angola", code: "AGO", flag: "🇦🇴"),
    Country(name: "Antigua and Barbuda", code: "ATG", flag: "🇦🇬"),
    Country(name: "Argentina", code: "ARG", flag: "🇦🇷"),
    Country(name: "Armenia", code: "ARM", flag: "🇦🇲"),
    Country(name: "Australia", code: "AUS", flag: "🇦🇺"),
    Country(name: "Austria", code: "AUT", flag: "🇦🇹"),
    Country(name: "Azerbaijan", code: "AZE", flag: "🇦🇿"),
    Country(name: "Bahamas", code: "BHS", flag: "🇧🇸"),
    Country(name: "Bahrain", code: "BHR", flag: "🇧🇭"),
    Country(name: "Bangladesh", code: "BGD", flag: "🇧🇩"),
    Country(name: "Barbados", code: "BRB", flag: "🇧🇧"),
    Country(name: "Belarus", code: "BLR", flag: "🇧🇾"),
    Country(name: "Belgium", code: "BEL", flag: "🇧🇪"),
    Country(name: "Belize", code: "BLZ", flag: "🇧🇿"),
    Country(name: "Benin", code: "BEN", flag: "🇧🇯"),
    Country(name: "Bhutan", code: "BTN", flag: "🇧🇹"),
    Country(name: "Bolivia", code: "BOL", flag: "🇧🇴"),
    Country(name: "Bosnia and Herzegovina", code: "BIH", flag: "🇧🇦"),
    Country(name: "Botswana", code: "BWA", flag: "🇧🇼"),
    Country(name: "Brazil", code: "BRA", flag: "🇧🇷"),
    Country(name: "Brunei", code: "BRN", flag: "🇧🇳"),
    Country(name: "Bulgaria", code: "BGR", flag: "🇧🇬"),
    Country(name: "Burkina Faso", code: "BFA", flag: "🇧🇫"),
    Country(name: "Burundi", code: "BDI", flag: "🇧🇮"),
    Country(name: "Cabo Verde", code: "CPV", flag: "🇨🇻"),
    Country(name: "Cambodia", code: "KHM", flag: "🇰🇭"),
    Country(name: "Cameroon", code: "CMR", flag: "🇨🇲"),
    Country(name: "Canada", code: "CAN", flag: "🇨🇦"),
    Country(name: "Central African Republic", code: "CAF", flag: "🇨🇫"),
    Country(name: "Chad", code: "TCD", flag: "🇹🇩"),
    Country(name: "Chile", code: "CHL", flag: "🇨🇱"),
    Country(name: "China", code: "CHN", flag: "🇨🇳"),
    Country(name: "Colombia", code: "COL", flag: "🇨🇴"),
    Country(name: "Comoros", code: "COM", flag: "🇰🇲"),
    Country(name: "Democratic Republic of the Congo", code: "COD", flag: "🇨🇩"),
    Country(name: "Republic of the Congo", code: "COG", flag: "🇨🇬"),
    Country(name: "Costa Rica", code: "CRI", flag: "🇨🇷"),
    Country(name: "Croatia", code: "HRV", flag: "🇭🇷"),
    Country(name: "Cuba", code: "CUB", flag: "🇨🇺"),
    Country(name: "Cyprus", code: "CYP", flag: "🇨🇾"),
    Country(name: "Czech Republic", code: "CZE", flag: "🇨🇿"),
    Country(name: "Denmark", code: "DNK", flag: "🇩🇰"),
    Country(name: "Djibouti", code: "DJI", flag: "🇩🇯"),
    Country(name: "Dominica", code: "DMA", flag: "🇩🇲"),
    Country(name: "Dominican Republic", code: "DOM", flag: "🇩🇴"),
    Country(name: "East Timor", code: "TLS", flag: "🇹🇱"),
    Country(name: "Ecuador", code: "ECU", flag: "🇪🇨"),
    Country(name: "Egypt", code: "EGY", flag: "🇪🇬"),
    Country(name: "El Salvador", code: "SLV", flag: "🇸🇻"),
    Country(name: "Equatorial Guinea", code: "GNQ", flag: "🇬🇶"),
    Country(name: "Eritrea", code: "ERI", flag: "🇪🇷"),
    Country(name: "Estonia", code: "EST", flag: "🇪🇪"),
    Country(name: "Eswatini", code: "SWZ", flag: "🇸🇿"),
    Country(name: "Ethiopia", code: "ETH", flag: "🇪🇹"),
    Country(name: "Fiji", code: "FJI", flag: "🇫🇯"),
    Country(name: "Finland", code: "FIN", flag: "🇫🇮"),
    Country(name: "France", code: "FRA", flag: "🇫🇷"),
    Country(name: "Gabon", code: "GAB", flag: "🇬🇦"),
    Country(name: "Gambia", code: "GMB", flag: "🇬🇲"),
    Country(name: "Georgia", code: "GEO", flag: "🇬🇪"),
    Country(name: "Germany", code: "DEU", flag: "🇩🇪"),
    Country(name: "Ghana", code: "GHA", flag: "🇬🇭"),
    Country(name: "Greece", code: "GRC", flag: "🇬🇷"),
    Country(name: "Grenada", code: "GRD", flag: "🇬🇩"),
    Country(name: "Guatemala", code: "GTM", flag: "🇵🇪"),
    Country(name: "Guinea", code: "GIN", flag: "🇬🇳"),
    Country(name: "Guinea-Bissau", code: "GNB", flag: "🇬🇲"),
    Country(name: "Guyana", code: "GUY", flag: "🇬🇾"),
    Country(name: "Haiti", code: "HTI", flag: "🇭🇹"),
    Country(name: "Honduras", code: "HND", flag: "🇭🇳"),
    Country(name: "Hungary", code: "HUN", flag: "🇭🇺"),
    Country(name: "Iceland", code: "ISL", flag: "🇮🇸"),
    Country(name: "India", code: "IND", flag: "🇮🇳"),
    Country(name: "Indonesia", code: "IDN", flag: "🇮🇩"),
    Country(name: "Iran", code: "IRN", flag: "🇮🇷"),
    Country(name: "Iraq", code: "IRQ", flag: "🇮🇶"),
    Country(name: "Ireland", code: "IRL", flag: "🇮🇪"),
    Country(name: "Israel", code: "ISR", flag: "🇮🇱"),
    Country(name: "Italy", code: "ITA", flag: "🇮🇹"),
    Country(name: "Jamaica", code: "JAM", flag: "🇯🇲"),
    Country(name: "Japan", code: "JPN", flag: "🇯🇵"),
    Country(name: "Jordan", code: "JOR", flag: "🇯🇴"),
    Country(name: "Kazakhstan", code: "KAZ", flag: "🇰🇿"),
    Country(name: "Kenya", code: "KEN", flag: "🇰🇪"),
    Country(name: "Kiribati", code: "KIR", flag: "🇰🇮"),
    Country(name: "North Korea", code: "PRK", flag: "🇰🇵"),
    Country(name: "South Korea", code: "KOR", flag: "🇰🇷"),
    Country(name: "Kosovo", code: "XKO", flag: "🇽🇰"),
    Country(name: "Kuwait", code: "KWT", flag: "🇰🇼"),
    Country(name: "Kyrgyzstan", code: "KGZ", flag: "🇰🇬"),
    Country(name: "Laos", code: "LAO", flag: "🇱🇦"),
    Country(name: "Latvia", code: "LVA", flag: "🇱🇻"),
    Country(name: "Lebanon", code: "LBN", flag: "🇱🇧"),
    Country(name: "Lesotho", code: "LSO", flag: "🇱🇸"),
    Country(name: "Liberia", code: "LBR", flag: "🇱🇸"),
    Country(name: "Libya", code: "LBY", flag: "🇱🇾"),
    Country(name: "Liechtenstein", code: "LIE", flag: "🇱🇮"),
    Country(name: "Lithuania", code: "LTU", flag: "🇱🇹"),
    Country(name: "Luxembourg", code: "LUX", flag: "🇱🇺"),
    Country(name: "Madagascar", code: "MDG", flag: "🇲🇬"),
    Country(name: "Malawi", code: "MWI", flag: "🇲🇼"),
    Country(name: "Malaysia", code: "MYS", flag: "🇲🇾"),
    Country(name: "Maldives", code: "MDV", flag: "🇲🇻"),
    Country(name: "Mali", code: "MLI", flag: "🇲🇱"),
    Country(name: "Malta", code: "MLT", flag: "🇲🇹"),
    Country(name: "Marshall Islands", code: "MHL", flag: "🇲🇭"),
    Country(name: "Mauritania", code: "MRT", flag: "🇲🇷"),
    Country(name: "Mauritius", code: "MUS", flag: "🇲🇺"),
    Country(name: "Mexico", code: "MEX", flag: "🇲🇽"),
    Country(name: "Micronesia", code: "FSM", flag: "🇫🇲"),
    Country(name: "Moldova", code: "MDA", flag: "🇲🇩"),
    Country(name: "Monaco", code: "MCO", flag: "🇲🇨"),
    Country(name: "Mongolia", code: "MNG", flag: "🇲🇳"),
    Country(name: "Montenegro", code: "MNE", flag: "🇲🇪"),
    Country(name: "Morocco", code: "MAR", flag: "🇲🇦"),
    Country(name: "Mozambique", code: "MOZ", flag: "🇲🇿"),
    Country(name: "Myanmar", code: "MMR", flag: "🇲🇲"),
    Country(name: "Namibia", code: "NAM", flag: "🇳🇦"),
    Country(name: "Nauru", code: "NRU", flag: "🇳🇷"),
    Country(name: "Nepal", code: "NPL", flag: "🇳🇵"),
    Country(name: "Netherlands", code: "NLD", flag: "🇳🇱"),
    Country(name: "New Zealand", code: "NZL", flag: "🇳🇿"),
    Country(name: "Nicaragua", code: "NIC", flag: "🇳🇮"),
    Country(name: "Niger", code: "NER", flag: "🇳🇪"),
    Country(name: "Nigeria", code: "NGA", flag: "🇳🇬"),
    Country(name: "North Macedonia", code: "MKD", flag: "🇲🇰"),
    Country(name: "Norway", code: "NOR", flag: "🇳🇴"),
    Country(name: "Oman", code: "OMN", flag: "🇴🇲"),
    Country(name: "Pakistan", code: "PAK", flag: "🇵🇰"),
    Country(name: "Palau", code: "PLW", flag: "🇵🇼"),
    Country(name: "Panama", code: "PAN", flag: "🇵🇦"),
    Country(name: "Papua New Guinea", code: "PNG", flag: "🇵🇬"),
    Country(name: "Paraguay", code: "PRY", flag: "🇵🇾"),
    Country(name: "Peru", code: "PER", flag: "🇵🇪"),
    Country(name: "Philippines", code: "PHL", flag: "🇵🇭"),
    Country(name: "Poland", code: "POL", flag: "🇵🇱"),
    Country(name: "Portugal", code: "PRT", flag: "🇵🇹"),
    Country(name: "Qatar", code: "QAT", flag: "🇶🇦"),
    Country(name: "Romania", code: "ROU", flag: "🇷🇴"),
    Country(name: "Russia", code: "RUS", flag: "🇷🇺"),
    Country(name: "Rwanda", code: "RWA", flag: "🇷🇼"),
    Country(name: "Saint Kitts and Nevis", code: "KNA", flag: "🇰🇳"),
    Country(name: "Saint Lucia", code: "LCA", flag: "🇱🇨"),
    Country(name: "Saint Vincent and the Grenadines", code: "VCT", flag: "🇻🇨"),
    Country(name: "Samoa", code: "WSM", flag: "🇼🇸"),
    Country(name: "San Marino", code: "SMR", flag: "🇸🇲"),
    Country(name: "São Tomé and Príncipe", code: "STP", flag: "🇸🇹"),
    Country(name: "Saudi Arabia", code: "SAU", flag: "🇸🇦"),
    Country(name: "Senegal", code: "SEN", flag: "🇸🇳"),
    Country(name: "Serbia", code: "SRB", flag: "🇷🇸"),
    Country(name: "Seychelles", code: "SYC", flag: "🇸🇨"),
    Country(name: "Sierra Leone", code: "SLE", flag: "🇸🇱"),
    Country(name: "Singapore", code: "SGP", flag: "🇸🇬"),
    Country(name: "Slovakia", code: "SVK", flag: "🇸🇰"),
    Country(name: "Slovenia", code: "SVN", flag: "🇸🇮"),
    Country(name: "Solomon Islands", code: "SLB", flag: "🇸🇧"),
    Country(name: "Somalia", code: "SOM", flag: "🇲🇿"),
    Country(name: "South Africa", code: "ZAF", flag: "🇿🇦"),
    Country(name: "South Sudan", code: "SSD", flag: "🇸🇸"),
    Country(name: "Spain", code: "ESP", flag: "🇪🇸"),
    Country(name: "Sri Lanka", code: "LKA", flag: "🇱🇰"),
    Country(name: "Sudan", code: "SDN", flag: "🇸🇩"),
    Country(name: "Suriname", code: "SUR", flag: "🇸🇷"),
    Country(name: "Sweden", code: "SWE", flag: "🇸🇪"),
    Country(name: "Switzerland", code: "CHE", flag: "🇨🇭"),
    Country(name: "Syria", code: "SYR", flag: "🇸🇾"),
    Country(name: "Taiwan", code: "TWN", flag: "🇹🇼"),
    Country(name: "Tajikistan", code: "TJK", flag: "🇹🇯"),
    Country(name: "Tanzania", code: "TZA", flag: "🇹🇿"),
    Country(name: "Thailand", code: "THA", flag: "🇹🇭"),
    Country(name: "Togo", code: "TGO", flag: "🇹🇬"),
    Country(name: "Tonga", code: "TON", flag: "🇹🇴"),
    Country(name: "Trinidad and Tobago", code: "TTO", flag: "🇹🇹"),
    Country(name: "Tunisia", code: "TUN", flag: "🇹🇳"),
    Country(name: "Turkey", code: "TUR", flag: "🇹🇷"),
    Country(name: "Turkmenistan", code: "TKM", flag: "🇹🇲"),
    Country(name: "Tuvalu", code: "TUV", flag: "🇹🇻"),
    Country(name: "Uganda", code: "UGA", flag: "🇺🇬"),
    Country(name: "Ukraine", code: "UKR", flag: "🇺🇦"),
    Country(name: "United Arab Emirates", code: "ARE", flag: "🇦🇪"),
    Country(name: "United Kingdom", code: "GBR", flag: "🇬🇧"),
    Country(name: "United States", code: "USA", flag: "🇺🇸"),
    Country(name: "Uruguay", code: "URY", flag: "🇺🇾"),
    Country(name: "Uzbekistan", code: "UZB", flag: "🇺🇿"),
    Country(name: "Vanuatu", code: "VUT", flag: "🇻🇺"),
    Country(name: "Vatican City", code: "VAT", flag: "🇻🇦"),
    Country(name: "Venezuela", code: "VEN", flag: "🇻🇪"),
    Country(name: "Vietnam", code: "VNM", flag: "🇻🇳"),
    Country(name: "Yemen", code: "YEM", flag: "🇾🇪"),
    Country(name: "Zambia", code: "ZMB", flag: "🇿🇲"),
    Country(name: "Zimbabwe", code: "ZWE", flag: "🇿🇼")
]
