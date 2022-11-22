
import SwiftUI

struct EpisodeList: View {
    @EnvironmentObject var consultar : ConsultarModelView
    @State private var isLoading: Bool = false
    let arrEpisodios : [Int]
    var body: some View {
        VStack{
            List(consultar.datosEpisodios, id: \.id){ item in
                Text(item.name)
            }
            .redacted(reason: isLoading ? .placeholder : [])
        }
        .task {
            do{
                isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    isLoading = false
                }
                try await consultar.consultarEpisodios(arrEpisodios)
                isLoading = false
            }catch{
                print(error)
            }
        }
    }
}

struct EpisodeList_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeList(arrEpisodios:[1,2])
    }
}
