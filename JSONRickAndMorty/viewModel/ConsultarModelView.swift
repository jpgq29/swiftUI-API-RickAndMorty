//
//  ConsultarModelView.swift
//  JSONRickAndMorty
//
//  Created by Appa on 21/11/22.
//

import Foundation

@MainActor
class ConsultarModelView: ObservableObject {
    
    @Published var datosModelo : Welcome = Welcome(results: [])
    @Published var datosEpisodio : Episodio = Episodio(id: 33, name: "")
    @Published var datosEpisodios : [Episodio] = []
    
    func consultar() async throws -> Void{
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { throw URLError(.badURL) }
        let (data,_) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(Welcome.self, from: data)
        self.datosModelo = response
    }
    
    func consultarEpisodio(_ idEpisodio:Int) async throws -> Void{
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode/\(idEpisodio)") else { throw URLError(.badURL) }
        let (data,_) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(Episodio.self, from: data)
        self.datosEpisodio = response
    }
    
    func consultarEpisodios(_ arrEpisodio: [Int]) async throws -> Void {
        guard arrEpisodio.count > 0 else { return }
        
        let stringArray = arrEpisodio.map { String($0) }
        let codigos = stringArray.joined(separator: ",")
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode/\(codigos)") else { throw URLError(.badURL) }
        let (data,_) = try await URLSession.shared.data(from: url)
        if arrEpisodio.count > 1 {
            let response = try JSONDecoder().decode([Episodio].self, from: data)
            self.datosEpisodios = response
        } else {
            let response = try JSONDecoder().decode(Episodio.self, from: data)
            self.datosEpisodios.append(response)
        }
    }
    
    func extraeIdEpisodios(_ data: [String]) -> [Int]{
        guard data.count > 0 else { return [] }
        var response : [Int] = []
        for item in data {
            guard let caracterCodigo = item.last else { break }
            let stringCodigo = String(caracterCodigo)
            guard let codigo = Int(stringCodigo) else { break }
            guard codigo > 0 else { break }
            response.append(codigo)
        }
        return response
    }
}
