//
//  ContentView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/13.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            NavigationView {
                NavigationLink(destination: MerucariView()) {
                    Text("検索")
                }
            }
                  }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
