//
//  ContentView.swift
//  chatGPT
//
//  Created by Mac on 19/4/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingText = false
    @State private var message = "Hello world!"
    @State private var numTaps = 0
    @State private var isNavigationActive = false
    
    let appearance = UINavigationBarAppearance()
    
    var body: some View {
        appearance.configureWithOpaqueBackground() // configure
        
        let backItemAppearance = UIBarButtonItemAppearance()
        backItemAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.white] // fix text color
        appearance.backButtonAppearance = backItemAppearance
        
        let image = UIImage(systemName: "chevron.backward")?.withTintColor(.white, renderingMode: .alwaysOriginal) // fix indicator color
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
                
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        
        return NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .padding()
                
                if isShowingText {
                    VStack {
                        Text(message)
                            .opacity(isShowingText ? 1.0 : 0.0)
                            .animation(.easeInOut(duration: 1.0))
                    }
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isShowingText = true
                }
            }
            .onTapGesture {
                numTaps += 1
                
                if numTaps == 4 {
                    isNavigationActive = true
                }
                else if numTaps == 3 {
                    withAnimation {
                        isShowingText = false
                    }
                    withAnimation(.easeInOut(duration: 1.0).delay(1.0)) {
                        message = "Tap to ask me anything"
                        isShowingText = true
                    }
                }
                else if numTaps == 2 {
                    withAnimation {
                        isShowingText = false
                    }
                    withAnimation(.easeInOut(duration: 1.0).delay(1.0)) {
                        message = "Powered by ChatGPT"
                        isShowingText = true
                    }
                }
                else {
                    withAnimation {
                        isShowingText = false
                    }
                    withAnimation(.easeInOut(duration: 1.0).delay(1.0)) {
                        message = "I am a generative AI chatbot"
                        isShowingText = true
                    }
                }
            }
            .navigationTitle("")

            .background(
                NavigationLink(destination: ChatView().navigationBarHidden(true), isActive: $isNavigationActive) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
