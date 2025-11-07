//
//  ContentView.swift
//  LiquidGlassDemo
//
//  Main navigation view for the demo app
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Basic Examples") {
                    NavigationLink("Shapes Gallery") {
                        ShapesGalleryView()
                    }
                    
                    NavigationLink("Custom Sizes") {
                        CustomSizesView()
                    }
                }
                
                Section("Interactive") {
                    NavigationLink("Hover Effects") {
                        HoverEffectsView()
                    }
                    
                    NavigationLink("Buttons & Controls") {
                        ButtonsControlsView()
                    }
                }
                
                Section("Real-World Examples") {
                    NavigationLink("Cards & Lists") {
                        CardsListView()
                    }
                    
                    NavigationLink("Profile UI") {
                        ProfileUIView()
                    }
                    
                    NavigationLink("Dashboard") {
                        DashboardView()
                    }
                }
                
                Section("Advanced") {
                    NavigationLink("Layered Effects") {
                        LayeredEffectsView()
                    }
                    
                    NavigationLink("Animations") {
                        AnimationsView()
                    }
                }
            }
            .navigationTitle("LiquidGlass Demo")
        }
    }
}

#Preview {
    ContentView()
}
