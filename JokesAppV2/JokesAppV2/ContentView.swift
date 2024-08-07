//
//  ContentView.swift
//  JokesAppV2
//
//  Created by Lesley Lopez on 8/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var jokeText = "This is a placeholder for the jokes!"
    
    var body: some View {
        
        ZStack{
            Color.purple
                .ignoresSafeArea()
            
            
            GeometryReader {geometry in
                VStack {
                    Text("My Joke App")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Text(jokeText)
                        .foregroundStyle(.white)
                        .bold()
                        .padding()
                    
                    Button(action: {
                        Task{
                            var joke = await callTheJokes()
                            jokeText = joke
                        }
                    }, label: {
                        Text("Joke")
                            .frame(width: 80, height: 40)
                            .background()
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 25, height: 25)))
                    })
                    .padding(.top)
                    
                    Spacer()
                    
                    Image("theJoker")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height / 2, alignment: .bottom)
                        .ignoresSafeArea(edges: .bottom)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    // My function for calling the joke API
    // add async - can run on background thread
    
    func callTheJokes() async -> String {
        
        //URL
        if let url = URL(string:"https://v2.jokeapi.dev/joke/Any?type=single") {
            //URL Request - this gets put into URL Session as a parameter
            
                let request = URLRequest(url: url)
    
            do {
                //URLSession
                let (data, response) = try await URLSession.shared.data(for: request)
                
                // Parse the data
                let decoder = JSONDecoder()
                
                do{
                    let results = try decoder.decode(JokeResponse.self, from: data)
                    return results.joke ?? "no joke was returned"
                    
                } catch {
                    print(error)
                }
                
            } catch {
                print(error)
            }
        }
        return "Houston, we have a problem"
    }
    
}

#Preview {
    ContentView()
}
