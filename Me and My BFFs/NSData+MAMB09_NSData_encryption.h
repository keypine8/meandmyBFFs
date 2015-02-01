//
//  NSData+MAMB09_NSData_encryption.h
//  Me&myBFFs
//
//  Created by Richard Koskela on 2015-01-24.
//  Copyright (c) 2015 Richard Koskela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MAMB09_NSData_encryption)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
