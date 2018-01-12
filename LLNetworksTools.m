//
//  LLNetworksTools.m
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//



#import "LLNetworksTools.h"
#define baseURL @""

@interface LLNetworksTools()<NSURLSessionDelegate>

@end

@implementation LLNetworksTools
static NSMutableArray *tasks;
static LLNetworksTools *instance =nil;
+(instancetype)sharedTools {
   
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        NSURL * baseUrl = [NSURL URLWithString:baseURL];
        NSURLSessionConfiguration  *congfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        //配置超时时长
        congfig.timeoutIntervalForRequest = 15;

          instance = [[self alloc]initWithBaseURL:baseUrl sessionConfiguration:congfig];
//        //设置支持HTTPS
//        NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
//        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
//        NSLog(@"%@", cerData);
//        instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[NSSet setWithObjects:cerData, nil]];
//        instance.securityPolicy.allowInvalidCertificates = YES;
//        [instance.securityPolicy setValidatesDomainName:NO];
        
        
           /*! 设置返回数据为json, 分别设置请求以及相应的序列化器 */
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        instance.responseSerializer = [AFJSONResponseSerializer serializer];
        
             /*! 复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        /*! 设置相应的缓存策略 */
        instance.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [instance.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        instance.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
    });
    return instance;
}
+(NSURLSessionTask *)requestWithType:(httpRequestType)type withUrlString:(NSString *)urlString withParameters:(NSDictionary *)parameters withSuccessBlock:(ResponseSuccess)successBlock withFailureBlock:(ResponseFail)failureBlock {
    
   // NSLog(@"请求地址----%@\n    请求参数----%@", urlString, parameters);
    if (urlString == nil)
    {
        return nil;
    }
    
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];
    
    NSURLSessionTask *sessionTask = nil;
    if (type == requestTypeGet)
    {
       
        sessionTask = [[self sharedTools] GET:URLString parameters:parameters  progress:^(NSProgress * _Nonnull downloadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
//            /****************************************************/
//            // 如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
//            NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[URLString hash]];
//            // 存储的沙盒路径
//            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//            // 归档
//            [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
            
            if (successBlock)
            {
                successBlock(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
            
         
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failureBlock)
            {
                failureBlock(error);
            }
            [[self tasks] removeObject:sessionTask];
            
        }];
        
    }
    else if (type == requestTypePost)
    {
        sessionTask = [[self sharedTools] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
//            /* ************************************************** */
//            //如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
//            NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[URLString hash]];
//            // 存储的沙盒路径
//            NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//            // 归档
//            [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
            
            if (successBlock)
            {
                successBlock(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
            if (failureBlock)
            {
                failureBlock(error);
            }
            [[self tasks] removeObject:sessionTask];
            
        }];
    }
    
    if (sessionTask)
    {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;


}












+ (NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        tasks = [NSMutableArray arrayWithCapacity:1];
    });
    return tasks;
}
+ (NSString *)strUTF8Encoding:(NSString *)str
{
    /*! ios9适配的话 打开第一个去空格 */  
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
 //   return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



+(id) sendSynchronousRequest:(NSString *)requsetUrlStr requsetType :(httpRequestType)type body :(NSDictionary *)dict
{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
     __block id  tempDict = nil;
     [self requestWithType:type withUrlString:requsetUrlStr withParameters:dict withSuccessBlock:^(id response) {
        tempDict = response;
        
        dispatch_semaphore_signal(semaphore);
    } withFailureBlock:^(NSError *error) {
        tempDict =nil;
        dispatch_semaphore_signal(semaphore);
        

    }];
    
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return tempDict;
 
}



 @end
