//
//  main.m
//  test
//
//  Created by Handlecar on 16/5/23.
//  Copyright © 2016年 date. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSDate *date = [dateFormatter dateFromString:@"20160522120000"];
        NSDate *today = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:date options:0];
        long hour = [d day] *24 + [d hour];
        NSString *minutes;
        NSString *hours;
        minutes = [NSString stringWithFormat:@"%02ld",(long)[d minute]];
        hours = [NSString stringWithFormat:@"%02ld", hour];
        NSLog(@"%@:%@",hours,minutes);
    }
    return 0;
}
