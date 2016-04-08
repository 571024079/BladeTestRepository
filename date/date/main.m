//
//  main.m
//  date
//
//  Created by Handlecar on 4/5/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        
        //创建了两个日期对象
        NSDate *date1=[dateFormatter dateFromString:@"2010-3-3 11:00"];
        NSDate *date2=[dateFormatter dateFromString:@"2010-3-4 12:00"];
        NSDate *date=[NSDate date];
        //NSString *curdate=[dateFormatter stringFromDate:date];
        
        //取两个日期对象的时间间隔：
        //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
        NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
        int days=((int)time)/(3600*24);
        int hours=((int)time)%(3600*24)/3600;
        NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
        NSLog(@"%ddays%dhours",days,hours);
    }
    return 0;
}
