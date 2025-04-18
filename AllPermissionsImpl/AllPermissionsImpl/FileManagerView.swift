//
//  AllFoldersView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI

final class FolderModel: Identifiable {
    var dirName: String
    var dirPath: FileManager.SearchPathDirectory
    
    init(dirName: String, dirPath: FileManager.SearchPathDirectory) {
        self.dirName = dirName
        self.dirPath = dirPath
    }
}

struct FileManagerView: View {
    @State var selectedDirectory = FileManager.SearchPathDirectory.allLibrariesDirectory
    var directories: [FolderModel] = [
        FolderModel(dirName: "Application", dirPath: FileManager.SearchPathDirectory.applicationDirectory),
        FolderModel(dirName: "Demo Application", dirPath: FileManager.SearchPathDirectory.demoApplicationDirectory),
        FolderModel(dirName: "Developer Application", dirPath: FileManager.SearchPathDirectory.developerApplicationDirectory),
        FolderModel(dirName: "Admin Application", dirPath: FileManager.SearchPathDirectory.adminApplicationDirectory),
        FolderModel(dirName: "Library", dirPath: FileManager.SearchPathDirectory.libraryDirectory),
        FolderModel(dirName: "Developer", dirPath: FileManager.SearchPathDirectory.developerDirectory),
        FolderModel(dirName: "User", dirPath: FileManager.SearchPathDirectory.userDirectory),
        FolderModel(dirName: "Documentation", dirPath: FileManager.SearchPathDirectory.documentationDirectory),
        FolderModel(dirName: "Document", dirPath: FileManager.SearchPathDirectory.documentDirectory),
        FolderModel(dirName: "Core Service", dirPath: FileManager.SearchPathDirectory.coreServiceDirectory),
        FolderModel(dirName: "Auto Saved Information", dirPath: FileManager.SearchPathDirectory.autosavedInformationDirectory),
        FolderModel(dirName: "Desktop", dirPath: FileManager.SearchPathDirectory.desktopDirectory),
        FolderModel(dirName: "Caches", dirPath: FileManager.SearchPathDirectory.cachesDirectory),
        FolderModel(dirName: "Application Support", dirPath: FileManager.SearchPathDirectory.applicationSupportDirectory),
        FolderModel(dirName: "Downloads", dirPath: FileManager.SearchPathDirectory.downloadsDirectory),
        FolderModel(dirName: "Input Methods", dirPath: FileManager.SearchPathDirectory.inputMethodsDirectory),
        FolderModel(dirName: "Movies", dirPath: FileManager.SearchPathDirectory.moviesDirectory),
        FolderModel(dirName: "Music", dirPath: FileManager.SearchPathDirectory.musicDirectory),
        FolderModel(dirName: "Pictures", dirPath: FileManager.SearchPathDirectory.picturesDirectory),
        FolderModel(dirName: "Printer Description", dirPath: FileManager.SearchPathDirectory.printerDescriptionDirectory),
        FolderModel(dirName: "Shared Public", dirPath: FileManager.SearchPathDirectory.sharedPublicDirectory),
        FolderModel(dirName: "Preference Panes", dirPath: FileManager.SearchPathDirectory.preferencePanesDirectory),
        FolderModel(dirName: "Item Replacement", dirPath: FileManager.SearchPathDirectory.itemReplacementDirectory),
        FolderModel(dirName: "All Applications", dirPath: FileManager.SearchPathDirectory.allApplicationsDirectory),
        FolderModel(dirName: "All Libraries", dirPath: FileManager.SearchPathDirectory.allLibrariesDirectory),
        FolderModel(dirName: "Trash", dirPath: FileManager.SearchPathDirectory.trashDirectory),
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(directories) { folder in
                        NavigationLink(destination: DirectoryView(searchPathDirectory: folder.dirPath)) {
                            ZStack {
                                Text(folder.dirName)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .border(Color.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}

struct DirectoryView: View {
    let rootDirectory: URL?
    @State private var folderContents: [URL] = []
    
    init(searchPathDirectory: FileManager.SearchPathDirectory) {
        self.rootDirectory = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first
    }
    
    var body: some View {
        List(folderContents, id: \.self) { url in
            NavigationLink(destination: SubfolderView(folderURL: url)) {
                Text(url.lastPathComponent)
            }
        }
        .onAppear {
            if let rootDirectory = rootDirectory {
                fetchFolderContents(url: rootDirectory)
            }
        }
    }
    
    func fetchFolderContents(url: URL) {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            self.folderContents = contents
        } catch {
            print("Error: \(error)")
        }
    }
}

struct SubfolderView: View {
    let folderURL: URL
    @State private var subfolderContents: [URL] = []
    
    var body: some View {
        List(subfolderContents, id: \.self) { url in
            NavigationLink(destination: SubfolderView(folderURL: url)) {
                Text(url.lastPathComponent)
            }
        }
        .onAppear {
            fetchSubfolderContents(url: folderURL)
        }
    }
    
    func fetchSubfolderContents(url: URL) {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            self.subfolderContents = contents
        } catch {
            print("Error: \(error)")
        }
    }
}

struct AllFoldersView_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerView()
    }
}
