//
//  Utils.swift
//  CandyStore
//
//  Created by Michael Moore on 4/1/22.
//

import Foundation
import CryptoKit

struct Utils {
    
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

// Specify the decimal place to round to using an enum
public enum RoundingPrecision {
    case ones
    case tenths
    case hundredths
    case thousands
}

// Round to the specific decimal place
public func preciseRound(
    _ value: Double,
    precision: RoundingPrecision = .ones) -> Double
{
    switch precision {
    case .ones:
        return round(value)
    case .tenths:
        return round(value * 10) / 10.0
    case .hundredths:
        return round(value * 100) / 100.0
    case .thousands:
        return round(value * 1000) / 1000.0
    }
}
