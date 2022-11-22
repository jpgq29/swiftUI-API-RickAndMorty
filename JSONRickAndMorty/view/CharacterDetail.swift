import SwiftUI

struct CharacterDetail: View {
    @EnvironmentObject var consultar : ConsultarModelView
    @State private var isLoading: Bool = false
    var object: Result
    var body: some View{
        VStack{
            AsyncImage(url: URL(string: object.image))
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .cornerRadius(8)
            HStack{
                Text("Nombre: ")
                    .fontWeight(.bold)
                Text(object.name)
            }
            HStack{
                Text("Especie: ")
                    .fontWeight(.bold)
                Text(object.species)
            }
            HStack{
                Text("Estado: ")
                    .fontWeight(.bold)
                Text(object.status)
            }
            HStack{
                Text("Sexo: ")
                    .fontWeight(.bold)
                Text(object.gender)
            }
            EpisodeList(arrEpisodios: consultar.extraeIdEpisodios(object.episode))
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .navigationTitle(object.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            do{
                isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    isLoading = false
                }
                try await consultar.consultarEpisodio(object.id)
                
            }catch{
                print(error)
            }
        }
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(object: Result(id: 1, name: "Nombre", status: "Vivo", species: "Humano", type: "", gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [], url: "", created: ""))
    }
}
