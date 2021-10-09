// 
// 


@import Foundation;

@interface NSData (ZMMessageDigest)

/// Calculates MD5 digest of the data
- (NSData *)zmMD5Digest;

/// Calculates HMAC digest of the data using SHA256
- (NSData *)zmHMACSHA256DigestWithKey:(NSData *)key;

/// Returns a random key to be used for SHA256
+ (NSData *)zmRandomSHA256Key;

/// Calculates SHA256 digest of the data
- (NSData *)zmSHA256Digest;

@end


@interface NSData (Base64Encoding)

- (NSString *)base64String;

@end


@interface NSData (ZMSCrypto)

/// Encodes the data using AES256 CBC Padding prefixing a random IV to the plain text data before encryption
/// This function keeps both original and encrypted data in memory. Do not use for large amount of data.
- (NSData *)zmEncryptPrefixingIVWithKey:(NSData *)key;

/// Decodes data using AES256 CBC Padding assuming that the first block is the encrypted IV
/// This function keeps both original and encrypted data in memory. Do not use for large amount of data.
- (NSData *)zmDecryptPrefixedIVWithKey:(NSData *)key;

/// Encodes the data using AES256 CBC Padding prefixing a random IV to the encrypted data
/// This function keeps both original and encrypted data in memory. Do not use for large amount of data.
- (NSData *)zmEncryptPrefixingPlainTextIVWithKey:(NSData *)key;

/// Decodes the data using AES256 CBC Padding assuming that the first block is the plaintext IV
/// This function keeps both original and encrypted data in memory. Do not use for large amount of data.
- (NSData *)zmDecryptPrefixedPlainTextIVWithKey:(NSData *)key;

/// Returns cryptograpically random data of a given length
+ (NSData *)secureRandomDataOfLength:(NSUInteger)length;

/// Returns a random key to be used as a AES256
+ (NSData *)randomEncryptionKey;

@end
