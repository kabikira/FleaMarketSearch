//
//  BackButton.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/18.
//

import SwiftUI

struct BackButtonView: View {
    @Binding var isShowView: Bool
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 5)
            Button {
                self.isShowView = false
            } label: {
                Text("検索画面に戻る")
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView(isShowView: .constant(false))
    }
}
