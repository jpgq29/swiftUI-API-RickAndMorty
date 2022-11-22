import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var consultar : ConsultarModelView
    @State private var buscador = ""
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                List(consultar.datosModelo.results.filter {buscador.isEmpty ? true : $0.name.contains(buscador)}, id: \.id){ item in
                    HStack{
                        AsyncImage(url: URL(string: item.image)) { Image in
                            Image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        VStack{
                            Text(item.name)
                                .font(.title)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        Spacer()
                        NavigationLink(destination: CharacterDetail(object: item)){}
                    }
                }
                .searchable(text: $buscador)
                .redacted(reason: isLoading ? .placeholder : [])
            }
            .navigationTitle("Rick And Morty")
        }
        .task {
            do{
                isLoading = true
                try await consultar.consultar()
                isLoading = false
            } catch {
                print(error)
            }
        }
    }
}
