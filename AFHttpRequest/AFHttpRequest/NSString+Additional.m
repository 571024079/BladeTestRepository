//
//  NSString+Additional.m
//  Handlecar
//
//  Created by liuzhaoxu on 14-8-22.
//  Copyright (c) 2014年 HanDou. All rights reserved.
//

#import "NSString+Additional.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Additional)

- (NSString*)md5
{
	const char* string = [self UTF8String];
	unsigned char result[16];
	CC_MD5(string, strlen(string), result);
	NSString* hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
					  result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
					  result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
	
	return [hash lowercaseString];
}

- (NSString *)convertFromFormat:(NSString *)aFormat toAnotherFormat:(NSString *)bFormat
{
    NSString *string;
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:aFormat];
    
    NSDate *date = [dateFormatter1 dateFromString:self];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:bFormat];
    
    string = [dateFormatter2 stringFromDate:date];
    
    if (string == nil || [self isEqualToString:@""]) {
        return @"";
    }
    
    return string;
}

- (BOOL)checkRegularExpression:(NSString*)regular regularOptions:(NSRegularExpressionOptions)regularOptions matchOptions:(NSMatchingOptions)matchOptions
{
    NSError* error = nil;
    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:regular options:regularOptions error:&error];
    if (expression)
    {
        NSRange searchRange = NSMakeRange(0, [self length]);
        NSTextCheckingResult *firstMatch=[expression firstMatchInString:self options:matchOptions range:searchRange];
        if (firstMatch)
        {
            return YES;
        }
    }
    return NO;
}

-(id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end
