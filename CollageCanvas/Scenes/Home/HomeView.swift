//
//  ContentView.swift
//  CollageCanvas
//
//  Created by Rodrigo Cavalcanti on 08/09/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            ScrollableCanvasView(vm: vm)
            AddImageButton
        }
        .sheet(isPresented: $vm.displayingSheet) {
            CuratedPhotosView(homeVM: vm)
        }
    }
}


// MARK: - Add Image Button
extension HomeView {
    var AddImageButton: some View {
        Button {
            vm.displayingSheet.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.largeTitle)
                .padding(.bottom)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView()
}
