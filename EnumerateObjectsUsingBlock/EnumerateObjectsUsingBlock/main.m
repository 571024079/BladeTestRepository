//
//  main.m
//  EnumerateObjectsUsingBlock
//
//  Created by Handlecar on 2017/3/10.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSMutableArray *models = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 10; i ++)
        {
            [models addObject:@"abc"];
        }
        for (NSInteger a = 0; a < 10; a++)
        {
            NSLog(@"马上开始");
            sleep(2);
            double date_s = CFAbsoluteTimeGetCurrent();
            [models enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //            NSLog(@"%@",obj);
            }];
            double date_e =  CFAbsoluteTimeGetCurrent();
            NSLog(@"enumerate Time: %f", date_e - date_s);
            //EnumerateObjectsUsingBlock[4443:74454] enumerate Time: 3.248109
            
            sleep(2);
            
            date_s =  CFAbsoluteTimeGetCurrent();
            for (id objc in models)
            {
                //            NSLog(@"%@",objc);
            }
            date_e =  CFAbsoluteTimeGetCurrent();
            NSLog(@"forin Time: %f", date_e - date_s);
            // EnumerateObjectsUsingBlock[4443:74454] forin Time: 2.808451
            
            sleep(2);
            
            date_s =  CFAbsoluteTimeGetCurrent();
            for (NSInteger i = 0; i < 10; i++)
            {
                id a = models[i];
                //            NSLog(@"%@",models[i]);
            }
            date_e =  CFAbsoluteTimeGetCurrent();
            NSLog(@"forloop Time: %f", date_e - date_s);
            // EnumerateObjectsUsingBlock[4443:74454] forloop Time: 4.120778
        }
    }
    return 0;
}
