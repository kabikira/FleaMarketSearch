//
//  ContentView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/13.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShowingView: Bool = false
    var body: some View {
        VStack {
            if isShowingView {
                MerucariView()
            } else {
                Button {
                    isShowingView.toggle()
                } label: {
                    Text("切り替え")
                }
            }
            
                  }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
