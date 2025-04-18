//
//  Data.swift
//  NestedTableNCollection
//
//  Created by Deepak Kaligotla on 26/03/25.
//

struct Item {
    let itemID: Int
    let itemType: Section
    let itemName: String
    let itemImage: String
    let itemDescription: String
    let itemDuration: Int
}

enum Section: String, CaseIterable {
    case Home = "Home"
    case TV_Shows = "TV Shows"
    case Movies = "Movies"
    case New_Popular = "New & Popular"
    case My_List = "My List"
    case Browse_by_Languages = "Browse by Languages"
}

let items: [Item] = [
    Item(itemID: 1, itemType: .New_Popular, itemName: "Adam Project", itemImage: "AdamProject", itemDescription: "A time-traveling pilot teams up with his younger self and his late father to come to terms with his past while saving the future.", itemDuration: 106),

    Item(itemID: 2, itemType: .New_Popular, itemName: "Adolescence", itemImage: "Adolescence", itemDescription: "A coming-of-age drama that explores the complexities of teenage emotions, relationships, and self-discovery.", itemDuration: 95),

    Item(itemID: 3, itemType: .Movies, itemName: "Don't Move", itemImage: "DontMove", itemDescription: "A gripping horror thriller where a cursed entity forces its victims to stay completely still or face a terrifying fate.", itemDuration: 98),

    Item(itemID: 4, itemType: .My_List, itemName: "Crime Patrol", itemImage: "CrimePatrol", itemDescription: "A crime investigation series that recreates real-life crime cases to spread awareness about law and safety.", itemDuration: 45),

    Item(itemID: 5, itemType: .My_List, itemName: "Plankton the Movie", itemImage: "PlanktonMovie", itemDescription: "An animated adventure following Plankton as he embarks on a quest to prove himself as more than just a small-time villain.", itemDuration: 90),

    Item(itemID: 6, itemType: .Home, itemName: "Dabba Cartel", itemImage: "DabbaCartel", itemDescription: "A high-stakes thriller about an underground network of smugglers operating through an unsuspecting food delivery service.", itemDuration: 50),

    Item(itemID: 7, itemType: .Movies, itemName: "The Mother", itemImage: "TheMother", itemDescription: "A relentless assassin comes out of hiding to protect her estranged daughter from dangerous forces.", itemDuration: 115),

    Item(itemID: 8, itemType: .Browse_by_Languages, itemName: "Khakee Bengal", itemImage: "Khakee", itemDescription: "A gripping police procedural that delves into Bengal's most challenging crime cases and the officers who solve them.", itemDuration: 55),

    Item(itemID: 9, itemType: .My_List, itemName: "Trolls 2", itemImage: "Trolls2", itemDescription: "A musical adventure where the Trolls discover new tribes with different music styles, leading to a colorful and action-packed journey.", itemDuration: 92),

    Item(itemID: 10, itemType: .Browse_by_Languages, itemName: "Khakee Bihar", itemImage: "KhakeeBihar", itemDescription: "A crime drama based on true events, depicting the bravery of Bihar police in tackling crime and corruption.", itemDuration: 60),

    Item(itemID: 11, itemType: .Movies, itemName: "The Electric State", itemImage: "ElectricState", itemDescription: "A sci-fi adventure set in a futuristic world where a teenage girl and her robot companion embark on a mission to find her missing brother.", itemDuration: 130),

    Item(itemID: 12, itemType: .TV_Shows, itemName: "The Residence", itemImage: "Residence", itemDescription: "A thrilling mystery series centered around a murder investigation in the White House, uncovering deep political secrets.", itemDuration: 48),

    Item(itemID: 13, itemType: .Movies, itemName: "Honeymoon Crasher", itemImage: "HoneymoonCrasher", itemDescription: "A romantic comedy where an uninvited guest turns a honeymoon trip into a chaotic yet hilarious adventure.", itemDuration: 102),

    Item(itemID: 14, itemType: .TV_Shows, itemName: "Wolf King", itemImage: "WolfKin", itemDescription: "A fantasy series about a young prince destined to unite warring wolf clans and reclaim his kingdom.", itemDuration: 50),

    Item(itemID: 15, itemType: .Movies, itemName: "Lift", itemImage: "Lift", itemDescription: "An action-packed heist thriller where a team attempts a daring mid-air robbery on a plane.", itemDuration: 107)
]
