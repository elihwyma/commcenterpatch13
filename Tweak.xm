@import Foundation;
#import <substrate.h>
//A new method from iOS 14

int returnOne() {
    return 1;
}

%ctor {
    NSArray *symbols = @[
        @"__Z50VerifyCarrierBundleVersionsXMLSignatureWithKeyTypePK14__CFDictionary16CBVersionsFormat15CBSignatureType16SignatureKeyType",
        @"_SecKeyRawVerify",
        @"__Z28VerifyCarrierBundleSignatureRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEE15CBSignatureType16SignatureKeyType",
        @"__Z39VerifyCarrierBundleVersionsXMLSignaturePK14__CFDictionary16CBVersionsFormat15CBSignatureType",
        @"__Z28VerifyCarrierBundleSignatureRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEP8__SecKey"
    ];
    for (NSString *symbol in symbols) {
        MSHookFunction(MSFindSymbol(NULL, symbol.UTF8String), (void *)returnOne, NULL);
    }
}
