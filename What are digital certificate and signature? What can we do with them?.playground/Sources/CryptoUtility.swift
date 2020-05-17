import Cocoa
import CryptoKit

public struct EDElements {
    public static var publicKey: SecKey?
    public static var privateKey: SecKey?
    public static var cipher: Data?
    public static var body: Data?
    public static var signature: Data?
    public static var certificate: Data?
    public static var caKeyPair: (SecKey, SecKey)?
}

public class CryptoUtility {
    
    public static func getKeyPair(size: Int) -> (SecKey, SecKey)? {
        var publicKey: SecKey!
        var privateKey: SecKey!
        
        let rsaKeyPar = [kSecAttrType: kSecAttrKeyTypeRSA, kSecAttrKeySizeInBits: size] as CFDictionary
        let status = SecKeyGeneratePair(rsaKeyPar, &publicKey, &privateKey)
        return status == errSecSuccess ? (publicKey, privateKey) : nil
    }
    
    public static func encrypt(data: Data, pubKey: SecKey, algorithm: SecKeyAlgorithm) -> Data? {
        let blockSzie = SecKeyGetBlockSize(pubKey)
        guard blockSzie > data.count else { return nil }
        
        var error: Unmanaged<CFError>?
        let ciphertext = SecKeyCreateEncryptedData(pubKey, algorithm, data as CFData, &error)
        if let ciphertext = ciphertext {
            return ciphertext as Data
        }
        return nil
    }
    
    public static func decrypt(data: Data, priKey: SecKey, algorithm: SecKeyAlgorithm) -> Data? {
        var error: Unmanaged<CFError>?
        let plaintext = SecKeyCreateDecryptedData(priKey, algorithm, data as CFData, &error)
        if let plaintext = plaintext {
            return plaintext as Data
        }
        return nil
    }
    
    public static func sign(data: Data, priKey: SecKey, algorithm: SecKeyAlgorithm) -> Data? {
        var error: Unmanaged<CFError>?
        let signature = SecKeyCreateSignature(priKey, algorithm, data as CFData, &error)
        if let signature = signature {
            return signature as Data
        }
        return nil
    }
    
    public static func verify(data: Data, signature: Data, pubKey: SecKey, algorithm: SecKeyAlgorithm) -> Bool {
        var error: Unmanaged<CFError>?
        let validate = SecKeyVerifySignature(pubKey, algorithm, data as CFData, signature as CFData, &error)
        return validate
    }
    
    public static func exportKeyToData(key: SecKey) -> Data? {
        var error: Unmanaged<CFError>?
        guard let data = SecKeyCopyExternalRepresentation(key, &error) as Data? else { return nil }
        return data
    }
    
    public static func hashData(data: Data) -> Data? {
        let hashed = SHA512.hash(data: data)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        guard let hashedData = hashString.data(using: .utf8) else { return nil }
        return hashedData
    }
    
}
