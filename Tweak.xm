@import Foundation;
#import <substrate.h>
//A new method from iOS 14

int returnOne() {
    #if DEBUG
    NSLog(@"[CCPatch] Returning 1 for signature verification");
    #endif
    return 1;
}

int returnZero() {
    #if DEBUG
    NSLog(@"[CCPatch] Returning 0 for signature verification");
    #endif
    return 0;
}

%ctor {
    #if DEBUG
    NSLog(@"[CCPatch] CommCenterPatch13 loaded");
    #endif
    
    NSArray *symbols = @[
        @"__Z50VerifyCarrierBundleVersionsXMLSignatureWithKeyTypePK14__CFDictionary16CBVersionsFormat15CBSignatureType16SignatureKeyType",
        @"__Z28VerifyCarrierBundleSignatureRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEE15CBSignatureType16SignatureKeyType",
        @"__Z39VerifyCarrierBundleVersionsXMLSignaturePK14__CFDictionary16CBVersionsFormat15CBSignatureType",
        @"__Z28VerifyCarrierBundleSignatureRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEP8__SecKey"
    ];
    for (NSString *symbolName in symbols) {
        void *symbol = MSFindSymbol(NULL, symbolName.UTF8String);
        if (!symbol) {
            continue;
        }
        #if DEBUG
        NSLog(@"[CCPatch] Hooking symbol: %@", symbolName);
        #endif 
        MSHookFunction(symbol, (void *)returnOne, NULL);
    }
    MSImageRef securityImage = MSGetImageByName("/System/Library/Frameworks/Security.framework/Security");
    if (securityImage) {
        // Returns OSStatus (0 for success)
        void *symbol = MSFindSymbol(securityImage, "_SecKeyRawVerify");
        if (symbol) {
            #if DEBUG
            NSLog(@"[CCPatch] Hooking symbol: _SecKeyRawVerify");
            #endif
            MSHookFunction(symbol, (void *)returnZero, NULL);
        }
        // Returns boolean (true for success)
        symbol = MSFindSymbol(securityImage, "_SecKeyVerifySignature");
        if (symbol) {
            #if DEBUG
            NSLog(@"[CCPatch] Hooking symbol: _SecKeyVerifySignature");
            #endif
            MSHookFunction(symbol, (void *)returnOne, NULL);
        }
    }
}