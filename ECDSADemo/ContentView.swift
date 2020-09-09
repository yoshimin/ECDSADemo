//
//  ContentView.swift
//  ECDSADemo
//
//  Created by Shingai Yoshimi on 2020/09/02.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModelImpl()

    var body: some View {
        VStack(spacing: 30.0) {
            Button(action: {
                do {
                    try self.viewModel.generateSignature()
                } catch {
                    print(error)
                }
            }, label: {
                Text("generate signature")
            })
            .padding(.top, 100)
            Text(viewModel.signature)
            .padding()
            Spacer()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
