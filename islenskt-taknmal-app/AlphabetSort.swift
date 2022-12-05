import SwiftUI

struct AlphabetSort: View {
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W", "X","Y", "Z"]
    let values = ["Avalue", "Bvalue", "Cvalue", "Dvalue", "Mvalue", "Zvalue"]
    var body: some View {
        ScrollView {
            ScrollViewReader { value in
                ZStack{
                    List{
                        ForEach(alphabet, id: \.self) { letter in
                            Section(header: Text(letter)) {
                                ForEach(values.filter { $0.hasPrefix(letter) }, id: \.self) { vals in
                                    Text(vals).id(vals)
                                }
                            }.id(letter)
                        }
                    }
                    HStack{
                        Spacer()
                        VStack {
                            ForEach(0..<alphabet.count, id: \.self) { idx in
                                Button(action: {
                                    withAnimation {
                                        value.scrollTo(alphabet[idx])
                                    }
                                }, label: {
                                    Text(idx % 2 == 0 ? alphabet[idx] : "\u{2022}")
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}

struct AlphabetSort_Previews: PreviewProvider {
    static var previews: some View {
        AlphabetSort()
    }
}
