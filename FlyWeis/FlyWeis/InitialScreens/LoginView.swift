//
//  LoginView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 09/08/24.
//

import SwiftUI
import Alamofire
import CoreLocation

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isAgreed: Bool = false
    @State private var checkPermissions = false
    @State private var showProgress = false
    @State private var loginError: String?
    @State private var loginSuccess = false
    @State private var progressStartTime: Date?
    @State var locationPermissionStatus = CLLocationManager().authorizationStatus
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .background(Color(red: 52/255, green: 183/255, blue: 193/255))
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, alignment: .top)
                        .padding(.top, 40)
                    
                    Text("Email ID").font(.title2).bold().padding(.horizontal, 40)
                    TextField("Enter email", text: $email)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 10)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.black),
                            alignment: .bottom
                        )
                        .padding(.horizontal, 40)
                    
                    Text("Password").font(.title2).bold().padding(.horizontal, 40)
                    HStack {
                        if isPasswordVisible {
                            TextField("Enter password", text: $password)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 10)
                                .autocapitalization(.none)
                                .keyboardType(.default) // Use default keyboard for regular text
                                .textContentType(.password)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(.black),
                                    alignment: .bottom
                                )
                        } else {
                            SecureField("Enter password", text: $password)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 10)
                                .autocapitalization(.none)
                                .keyboardType(.default)
                                .textContentType(.password)
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(.black),
                                    alignment: .bottom
                                )
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    HStack {
                        Toggle(isOn: $isAgreed) {
                            HStack(spacing: 5) { // Adjust spacing as needed
                                Text("By using xyz-product I agree to")
                                    .font(.caption)
                                NavigationLink(destination: TermsandConditionsView()) {
                                    Text("Terms & Conditions").font(.caption).underline().foregroundColor(.blue)
                                }
                                Text("and").font(.caption)
                                NavigationLink(destination: PrivacyPolicyView()) {
                                    Text("Privacy Policy").font(.caption).underline().foregroundColor(.blue)
                                }
                            }
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 40)
                    Spacer()
                    
                    Text("Support").font(.headline).bold().padding(.horizontal, 40)
                    Text("Contact xyz-company at")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 40)
                    
                    HStack(spacing: 10) {
                        Link(destination: URL(string: "mailto:support@xyz.com")!) {
                            Text("support@xyz.com")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                        
                        Text("or")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Link(destination: URL(string: "tel:+10000000000")!) {
                            Text("+1(000) 000-0000")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 40)
                    Spacer()
                    
                    NavigationLink(
                        destination: MainView().navigationBarBackButtonHidden(true),
                        isActive: $loginSuccess,
                        label: {
                            Button(action: {
                                if isFormValid {
                                    performLogin()
                                }
                            }) {
                                Text("Login")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .background(isFormValid ? Color(red: 52/255, green: 183/255, blue: 193/255) : Color.gray)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 40)
                            }
                            .disabled(!isFormValid)
                        }
                    )
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    Spacer()
                }
                
                if showProgress {
                    VStack(alignment: .center) {
                        Spacer().frame(height: 100)
                        VStack {
                            if let error = loginError {
                                Text("Login Failed").font(.headline).foregroundColor(.red)
                                Text(error).font(.subheadline).foregroundColor(.red)
                            } else {
                                Text("Login Successful").font(.headline).foregroundColor(.green)
                                Text("Please wait, synchronization in progress...").font(.subheadline)
                            }
                        }
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.4))
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                }
            }
        }
    }
    
    private func performLogin() {
        let signInRequest = SignInRequest(
            email: email,
            password: password,
            deviceToken: "",
            userType: ""
        )
        
        showProgress = true
        progressStartTime = Date()
        
        API.signIn(with: signInRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if response.status == "success" {
                        loginError = nil
                        loginSuccess = true
                    } else {
                        loginError = response.message
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        showProgress = false
                    }
                case .failure(let error):
                    loginError = error.localizedDescription
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        showProgress = false
                    }
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        return isValidEmail(email) && !password.isEmpty && isAgreed
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    @ViewBuilder
    private var destinationView: some View {
        if locationPermissionStatus == .authorizedAlways {
            MainView().navigationBarBackButtonHidden(true)
        } else {
            PermissionView().navigationBarBackButtonHidden(true)
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? Color(red: 52/255, green: 183/255, blue: 193/255) : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

#Preview {
    LoginView()
}
