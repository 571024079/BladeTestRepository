//
//  ViewController.m
//  coreDataDemo
//
//  Created by Handlecar on 16/5/17.
//  Copyright © 2016年 Handlecar. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "FastCheckModel+CoreDataProperties.h"
#import "DetailModel+CoreDataProperties.h"
#import "ListCoredataModel+CoreDataProperties.h"
#import "Ncb015CoredataModel+CoreDataProperties.h"
#import "CpositemsModel+CoreDataProperties.h"
#define kManagedObjectContext [CoreDataManager sharedInstance].managedObjectContext

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CoreDataManager sharedInstance] managedObjectModel];
    /*
     param {
     cid = 10;
     shid = 574;
     sttid = 310;
     }
     */
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@10 forKey:@"cid"];
    [param setObject:@574 forKey:@"shid"];
    [param setObject:@310 forKey:@"sttid"];
    
    NSString *str = @"http://139.196.196.137:3008/ncb038";
//    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *queryStr = [NSString stringWithFormat:@"%@=%@",[@"data" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[jsonStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
   NSURL *url =[NSURL URLWithString:str] ;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[queryStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
        NSDictionary *datainfo = [dict objectForKey:@"data"];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"FastCheckModel"
                                       
                                                  inManagedObjectContext:kManagedObjectContext];
        
        [request setEntity:entity];
        
        //使用谓词NSPredicate  添加查询条件 相当于sqlite中的sql语句
        
        NSPredicate *predict = [NSPredicate predicateWithFormat:@"cstatusid = %@" ,[datainfo objectForKey:@"cstatusid"]];
        
        if (predict) {[request setPredicate:predict];}
        
        //设置 获得数组的 排序方式(可根据需要 设置添加)
        
        NSSortDescriptor *byCourseName = [NSSortDescriptor sortDescriptorWithKey:@"cstatus"ascending:YES];
        
        NSSortDescriptor *byCourseId = [NSSortDescriptor sortDescriptorWithKey:@"remark" ascending:YES];
        
        NSArray *sortDescriptors = [NSMutableArray arrayWithObjects:byCourseName,byCourseId, nil];
        
        [request setSortDescriptors:sortDescriptors];
        
        NSError *error1 = nil;
        
        NSArray *objectResults  = [kManagedObjectContext
                                   
                                   executeFetchRequest:request
                                   
                                   error:&error1];
        for (id object in objectResults)
        {
            NSLog(@"object %@",object);
        }
        
        //
        FastCheckModel *fashCheckEntity = [NSEntityDescription insertNewObjectForEntityForName:@"FastCheckModel" inManagedObjectContext:kManagedObjectContext];
        fashCheckEntity.cstatus = [datainfo objectForKey:@"cstatus"];
        fashCheckEntity.cstatusid = [datainfo objectForKey:@"cstatusid"];
        fashCheckEntity.remark = [datainfo objectForKey:@"remark"];
        
        NSArray *ncb015list = [datainfo objectForKey:@"ncb015list"];
        // 173 检查项
        NSMutableSet *ncb015listset = [NSMutableSet set];
        for (NSDictionary *cpitemInfo in ncb015list)
        {
            Ncb015CoredataModel *ncb015Model = [NSEntityDescription insertNewObjectForEntityForName:@"Ncb015CoredataModel" inManagedObjectContext:kManagedObjectContext];
            ncb015Model.cposid = [cpitemInfo objectForKey:@"cposid"];
            ncb015Model.cposname = [cpitemInfo objectForKey:@"cposname"];
            NSArray *cpositemsInfo = [cpitemInfo objectForKey:@"cpositems"];
            NSMutableSet *cpset = [NSMutableSet set];
            for (NSDictionary *cpmodel in cpositemsInfo)
            {
                CpositemsModel *cposModel = [NSEntityDescription insertNewObjectForEntityForName:@"CpositemsModel" inManagedObjectContext:kManagedObjectContext];
                // demo
                /*
                 @property (nullable, nonatomic, retain) NSNumber *badPhotoCount;
                 @property (nullable, nonatomic, retain) NSNumber *cgoodphotoid;
                 @property (nullable, nonatomic, retain) NSString *cgoodphotoprourl;
                 @property (nullable, nonatomic, retain) NSString *cgoodphotourl;
                 @property (nullable, nonatomic, retain) NSNumber *cguideid;
                 @property (nullable, nonatomic, retain) NSString *cguideimg;
                 @property (nullable, nonatomic, retain) NSString *cguideremark;
                 @property (nullable, nonatomic, retain) NSNumber *cid;
                 @property (nullable, nonatomic, retain) NSString *cname;
                 @property (nullable, nonatomic, retain) NSNumber *cnt;
                 @property (nullable, nonatomic, retain) NSNumber *cpartid;
                 @property (nullable, nonatomic, retain) NSNumber *cpbcnt;
                 @property (nullable, nonatomic, retain) Ncb015CoredataModel *relationship;
                 @property (nullable, nonatomic, retain) NSSet<DetailModel *> *cbadphotos;
                 @property (nullable, nonatomic, retain) NSSet<ListCoredataModel *> *clist;
                 */
//                [cposModel setValuesForKeysWithDictionary:cpmodel];
        
                cposModel.badPhotoCount = [[cpmodel objectForKey:@"cbadphotos"] isKindOfClass:[NSNull class]] ? @0:@([[cpmodel objectForKey:@"cbadphotos"] count]);
                cposModel.cgoodphotoid = [cpmodel objectForKey:@"cgoodphotoid"];
                cposModel.cgoodphotoprourl = [cpmodel objectForKey:@"cgoodphotoprourl"];
                cposModel.cgoodphotourl = [cpmodel objectForKey:@"cgoodphotourl"];
                cposModel.cguideid = [cpmodel objectForKey:@"cguideid"];
                cposModel.cguideimg = [cpmodel objectForKey:@"cguideimg"];
                cposModel.cguideremark = [cpmodel objectForKey:@"cguideremark"];
                cposModel.cid = [cpmodel objectForKey:@"cid"];
                cposModel.cname = [cpmodel objectForKey:@"cname"];
                cposModel.cnt = [cpmodel objectForKey:@"cnt"];
                cposModel.cpartid = [cpmodel objectForKey:@"cpartid"];
                cposModel.cpbcnt = [cpmodel objectForKey:@"cpbcnt"];
                NSMutableSet *cbadphotoset = [NSMutableSet set];
                NSArray *cpmodelArray = [cpmodel objectForKey:@"cbadphotos"];
                if ([cpmodelArray isKindOfClass:[NSNull class]])
                {
                    cpmodelArray = @[];
                }
                for (NSDictionary *cbadphotosInfo in cpmodelArray)
                {
                    DetailModel *detailModel = [NSEntityDescription insertNewObjectForEntityForName:@"DetailModel" inManagedObjectContext:kManagedObjectContext];
                    [detailModel setValuesForKeysWithDictionary:cbadphotosInfo];
                    [cbadphotoset addObject:detailModel];
                }
                [cposModel addCbadphotos:cbadphotoset];
                [cpset addObject:cposModel];
            }
            [ncb015Model addCpositems:cpset];
            [ncb015listset addObject:ncb015Model];

        }
        [fashCheckEntity addNcb015list:ncb015listset];
        [[CoreDataManager sharedInstance] saveContext]; //插入 保存

    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
