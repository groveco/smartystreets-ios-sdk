import Foundation
import smartystreetsiOSSDKCore

class USAutocompleteExample {
    func run() -> String {
        //        let authId = ProcessInfo.processInfo.environment["SMARTY_AUTH_ID"]
        //        let authToken = ProcessInfo.processInfo.environment["SMARTY_AUTH_TOKEN"]
        //        let client = ClientBuilder(authId: authId ?? "", authToken: authToken ?? "").buildUSAutocompleteApiClient()
        let authId = "ID"
        let authToken = "TOKEN"
        let client = ClientBuilder(authId: authId, authToken: authToken).buildUSAutocompleteApiClient()
        
        //            Documentation for input fields can be found at:
        //            https://smartystreets.com/docs/us-autocomplete-api#http-request-input-fields
        
        var lookup = USAutocompleteLookup().withPrefix(prefix: "4770 Lincoln Ave O")
        var error:NSError! = nil
        
        _ = client.sendLookup(lookup: &lookup, error: &error)
        
        if let error = error {
            let output = """
            Domain: \(error.domain)
            Error Code: \(error.code)
            Description:\n\(error.userInfo[NSLocalizedDescriptionKey] as! NSString)
            """
            return output
        }
        
        var output = "Result:\n"
        
        if let result = lookup.result, let suggestions = result.suggestions {
            for suggestion in suggestions {
                 output.append("\(suggestion.text ?? "")\n")
            }
        }
        return output
    }
}