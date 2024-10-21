//
//  ContentView.swift
//  SUIFundamentals
//
//  Created by Alan Ulises on 19/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var enRojo = false
    @State private var alerta = false
    @State private var counter = 0
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!\(self.counter)").foregroundColor(self.enRojo ? .red:.blue)
            Toggle(isOn: $enRojo) {
                Text("Toggle en Rojo activo")
            }
            Button{
                print("Button touched")
                self.incremento()
            }label: {
                Text("Touch Me")
            }.background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(10)
            Button{
                self.pruebaAlert()
            }label: {
                Text("Trying yout luck")
            }.background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(10)
                .alert(isPresented: $alerta, content: {
                    Alert(title: Text("SUI"),message: Text("Bravo you win"),dismissButton: .default(Text("yeiii")))
                })
        }
        .padding()
    }
    func incremento(){
        self.counter  += 1
    }
    func pruebaAlert(){
        self.alerta  = (self.counter == 10)
    }
}


#Preview {
    ContentView()
}
