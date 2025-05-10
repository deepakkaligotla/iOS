//
//  TodoViewModel.swift
//  Assignment07
//
//  Created by Deepak Kaligotla on 11/05/25.
//

class TodoViewModel {
    var todos: [Todo] = []

    func fetchTodos() async {
        do {
            self.todos = try await NetworkService.shared.getAllTodos()
        } catch {
            print("Failed to fetch todos: \(error.localizedDescription)")
        }
    }
}
