//
//  ContentView.swift
//  FaceAuthenticationInSwiftUI
//
//  Created by ramil on 02.05.2021.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    var context = LAContext()
    
    init() {
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }
    
    @State private var isLogged: Bool = false
    
    var body: some View {
        Button(action: {
            
        }, label: {
            Text(isLogged ? "Logout" : "Login")
                .font(.largeTitle)
        })
    }
    
    private func login() {
        if !isLogged {
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Login into the application"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                    if success {
                        DispatchQueue.main.async {
                            isLogged = true
                        }
                    } else {
                        print("Error \(error?.localizedDescription ?? "")")
                    }
                }
            } else {
                print("Error found \(error?.localizedDescription ?? "Nothing found")")
            }
        } else {
            DispatchQueue.main.async {
                isLogged = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
