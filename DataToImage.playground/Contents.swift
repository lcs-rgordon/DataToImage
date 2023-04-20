import SwiftUI

func fetchImage() async -> Image? {

    // 1. Attempt to create a URL from the address provided
    let endpoint = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=Example"
    guard let url = URL(string: endpoint) else {
        print("Invalid address")
        return nil
    }

    // 2. Fetch the raw data from the URL
    //
    // Network requests can potentially fail (throw errors) so
    // we complete them within a do-catch block to report errors if they
    // occur.
    //
    do {
        
        // Fetch the data
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // 3. Attempt to decode the raw data into an instance of the UIImage type and then a SwiftUI image
        if let uiImageInstance = UIImage(data: data) {
            
            let swiftUIImageInstance = Image(uiImage: uiImageInstance)
            return swiftUIImageInstance
            
        } else {
            
            return nil
            
        }

    } catch {
        
        // Show an error that we wrote and understand
        print("Count not retrieve data from endpoint, or could not decode into an image.")
        print("----")
        
        // Show the detailed error to help with debugging
        print(error.localizedDescription)
        return nil
        
    }

    
}

Task {
    let image = await fetchImage()
}

