//
//  PermissionListPopup.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 28/03/24.
//

import SwiftUI

struct PermissionListPopup: View {
    var permissions: [PermissionModel]
    @Binding var isPresented: Bool
    var didSelectPermission: ((PermissionModel) -> Void)?
    
    var body: some View {
        VStack {
            Text("Permissions")
                .font(.headline)
                .padding()
            Divider()
            List(permissions, id: \.self) { permission in
                Button(action: {
                    didSelectPermission?(permission)
                    isPresented = false
                }) {
                    Text(permission.name)
                }
            }
        }
    }
}
