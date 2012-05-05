//
//  NSStringAdditions.m
//  Daifugo
//
//  Confidential
//

#import "NSStringAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (NSStringAdditions)

- (NSString *)MD5String {
	const char *cStr = [self UTF8String];
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cStr, strlen(cStr), digest);
	char md5string[CC_MD5_DIGEST_LENGTH*2];
	int i;
	for(i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
		sprintf(md5string+i*2, "%02X", digest[i]);
	}
	return [[NSString stringWithCString:md5string encoding:NSUTF8StringEncoding] lowercaseString];
}

@end
