import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            // Renkli gradyan arka plan
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Choose what you want ...")
                    .font(.system(size: 24, weight: .bold))
                    .fontWeight(.bold)
                    .padding()

                Button(action: {
                    createTemporaryFile(withExtension: "yaml")
                }) {
                    HStack {
                        Image(systemName: "doc.plaintext") // .yaml için ikon
                            .font(.largeTitle)
                        Text(".yaml") // Buton içinde .yaml metni
                            .font(.headline)
                    }
                    .padding()
                    .frame(width: 170, height: 100) // Buton boyutu
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                Button(action: {
                    createTemporaryFile(withExtension: "txt")
                }) {
                    HStack {
                        Image(systemName: "doc.text") // .txt için ikon
                            .font(.largeTitle)
                        Text(".txt") // Buton içinde .txt metni
                            .font(.headline)
                    }
                    .padding()
                    .frame(width: 170, height: 100) // Buton boyutu
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                Spacer()
            }
            .frame(width: 350, height: 320) // Sabit pencere boyutu
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("File Created"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func createTemporaryFile(withExtension ext: String) {
        let fileName = "Untitled.\(ext)"
        let filePath = NSTemporaryDirectory().appending(fileName)
        let fileURL = URL(fileURLWithPath: filePath)

        // Dosya oluşturma ve açma
        do {
            try "".write(to: fileURL, atomically: true, encoding: .utf8)
            NSWorkspace.shared.open(fileURL)
            alertMessage = "\(fileName) has been created."
            showingAlert = true
        } catch {
            alertMessage = "Failed to create file: \(error.localizedDescription)"
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
