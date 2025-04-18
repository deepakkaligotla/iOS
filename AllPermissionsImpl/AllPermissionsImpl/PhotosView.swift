//
//  PhotosView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import Photos
import PhotosUI
import Foundation
import OSLog

struct PhotosView: View {
    @StateObject var photosModel = PhotosViewModel()
    
    var body: some View {
        VStack {
            PhotosGridView()
        }
        .environmentObject(photosModel)
        .navigationViewStyle(.stack)
    }
}

struct PhotosGridView: View {
    @EnvironmentObject var dataModel: PhotosViewModel
    @State private var selectedAlbum: PHAssetCollection?
    private static let initialColumns = 3
    @State private var isAddingPhoto = false
    @State private var isEditing = false
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns
    
    private var columnsTitle: String {
        gridColumns.count > 1 ? "\(gridColumns.count) Columns" : "1 Column"
    }
    
    var body: some View {
        VStack {
            if selectedAlbum == nil {
                ScrollView {
                    LazyVGrid(columns: gridColumns) {
                        ForEach(dataModel.albums, id: \.localIdentifier) { album in
                            Button(action: {
                                selectedAlbum = album
                            }) {
                                Text(album.localizedTitle ?? "Untitled Album")
                            }
                            .padding()
                        }
                    }
                    .padding()
                }
            } else {
                AlbumPhotosView(album: selectedAlbum!, numColumns: $numColumns)
                    .navigationBarTitle(selectedAlbum!.localizedTitle ?? "Album")
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Back") {
                                selectedAlbum = nil
                            }
                        }
                    }
            }
        }
        .navigationBarTitle("Image Gallery")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingPhoto) {
            PhotoPicker()
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosGridView().environmentObject(PhotosViewModel())
            .previewDevice("iPad (8th generation)")
    }
}

struct AlbumPhotosView: View {
    let album: PHAssetCollection
    @Binding var numColumns: Int
    @State private var photos: [PHAsset] = []
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: numColumns)) {
                ForEach(photos, id: \.localIdentifier) { photo in
                    PhotoCell(asset: photo, numColumns: numColumns)
                }
            }
            .padding()
        }
        .onAppear {
            fetchPhotos()
        }
    }
    
    private func fetchPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchResult = PHAsset.fetchAssets(in: album, options: fetchOptions)
        var fetchedPhotos: [PHAsset] = []
        fetchResult.enumerateObjects { (asset, _, _) in
            fetchedPhotos.append(asset)
        }
        photos = fetchedPhotos
    }
}

struct PhotoCell: View {
    let asset: PHAsset
    let numColumns: Int
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width / CGFloat(numColumns), height: UIScreen.main.bounds.width / CGFloat(numColumns))
                .clipped()
        } else {
            Color.clear
                .onAppear {
                    fetchImage()
                }
        }
    }
    
    private func fetchImage() {
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: UIScreen.main.bounds.width / CGFloat(numColumns), height: UIScreen.main.bounds.width / CGFloat(numColumns)), contentMode: .aspectFill, options: nil) { (image, _) in
            self.image = image
        }
    }
}

class PhotosViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var albums: [PHAssetCollection] = []
    
    init() {
        if let documentDirectory = FileManager.default.documentDirectory {
            let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage }
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
        
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
        userAlbums.enumerateObjects { (collection, _, _) in
            self.albums.append(collection)
        }
        
        if let urls = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil) {
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
    }
    
    func addItem(_ item: Item) {
        items.insert(item, at: 0)
    }
    
    func removeItem(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            FileManager.default.removeItemFromDocumentDirectory(url: item.url)
        }
    }
}

extension URL {
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
}

struct ColumnStepper: View {
    let title: String
    let range: ClosedRange<Int>
    @Binding var columns: [GridItem]
    @State private var numColumns: Int
    
    init(title: String, range: ClosedRange<Int>, columns: Binding<[GridItem]>) {
        self.title = title
        self.range = range
        self._columns = columns
        self.numColumns = columns.count
    }
    
    var body: some View {
        Stepper(title, value: $numColumns, in: range, step: 1) { _ in
            withAnimation { columns = Array(repeating: GridItem(.flexible()), count: numColumns) }
        }
    }
}

struct ColumnStepper_Previews: PreviewProvider {
    static var previews: some View {
        ColumnStepper(title: "ColumnStepper", range: 1...8, columns: .constant(Array(repeating: GridItem(.flexible()), count: 5)))
    }
}

struct DetailView: View {
    let item: Item
    
    var body: some View {
        AsyncImage(url: item.url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "mushy1", withExtension: "jpg") {
            DetailView(item: Item(url: url))
        }
    }
}

struct GridItemView: View {
    let size: Double
    let item: Item
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: item.url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
        }
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "mushy1", withExtension: "jpg") {
            GridItemView(size: 50, item: Item(url: url))
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @EnvironmentObject var dataModel: PhotosViewModel
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> PHPickerViewController {
        
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.preferredAssetRepresentationMode = .current
        
        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator
        return photoPickerViewController
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<PhotoPicker>) {
        // No updates are necessary.
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    let parent: PhotoPicker
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        self.parent.dismiss()
        
        guard
            let result = results.first,
            result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier)
        else { return }
        
        result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
            if let error = error {
                print("Error loading file representation: \(error.localizedDescription)")
            } else if let url = url {
                if let savedUrl = FileManager.default.copyItemToDocumentDirectory(from: url) {
                    Task { @MainActor [dataModel = self.parent.dataModel] in
                        withAnimation {
                            let item = Item(url: savedUrl)
                            dataModel.addItem(item)
                        }
                    }
                }
            }
        }
    }
    
    init(_ parent: PhotoPicker) {
        self.parent = parent
    }
}

extension FileManager {
    var documentDirectory: URL? {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func copyItemToDocumentDirectory(from sourceURL: URL) -> URL? {
        guard let documentDirectory = documentDirectory else { return nil }
        let fileName = sourceURL.lastPathComponent
        let destinationURL = documentDirectory.appendingPathComponent(fileName)
        if self.fileExists(atPath: destinationURL.path) {
            return destinationURL
        } else {
            do {
                try self.copyItem(at: sourceURL, to: destinationURL)
                return destinationURL
            } catch let error {
                print("Unable to copy file: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    func removeItemFromDocumentDirectory(url: URL) {
        guard let documentDirectory = documentDirectory else { return }
        let fileName = url.lastPathComponent
        let fileUrl = documentDirectory.appendingPathComponent(fileName)
        if self.fileExists(atPath: fileUrl.path) {
            do {
                try self.removeItem(at: url)
            } catch let error {
                print("Unable to remove file: \(error.localizedDescription)")
            }
        }
    }
    
    func getContentsOfDirectory(_ url: URL) -> [URL] {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory), isDirectory.boolValue else { return [] }
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        } catch let error {
            print("Unable to get directory contents: \(error.localizedDescription)")
        }
        return []
    }
}

struct Item: Identifiable {
    
    let id = UUID()
    let url: URL
    
}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView()
    }
}
