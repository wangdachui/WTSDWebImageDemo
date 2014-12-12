//
//  ViewController.m
//  WTSDWebImageDemo
//
//  Created by ZZWangtao on 14-12-12.
//  Copyright (c) 2014年 ZZWangtao. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *image1;

@property (strong, nonatomic) IBOutlet UIImageView *image2;

@end

@implementation ViewController
- (IBAction)clearAction:(UIButton *)sender {
    
    [[SDImageCache sharedImageCache] clearDisk];
    
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)imageCache:(UIButton *)sender {
    
    
    NSURL* imagePath1 = [NSURL URLWithString:@"http://s15.sinaimg.cn/middle/9914f9fdhbc6170891ebe&690"];
    
    NSURL* imagePath2 = [NSURL URLWithString:@"http://s14.sinaimg.cn/middle/9914f9fdhbc611c219f3d&690"];
    
    //图片缓存的基本代码，就是这么简单
    [self.image1 sd_setImageWithURL:imagePath1];
    
    //用block 可以在图片加载完成之后做些事情
    [self.image2 sd_setImageWithURL:imagePath2 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        NSLog(@"这里可以在图片加载完成之后做些事情");
        
    }];
    
    //覆盖方法，指哪打哪，这个方法是下载imagePath2的时候响应
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:imagePath2 options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        NSLog(@"显示当前进度");
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        NSLog(@"下载完成");
    }];

//    
//    //给一张默认图片，先使用默认图片，当图片加载完成后再替换
//    [self.image1 sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:@"default"]];
//    
//    //使用默认图片，而且用block 在完成后做一些事情
//    [self.image1 sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:@"default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        NSLog(@"图片加载完成后做的事情");
//        
//    }];
//    
//    //options 选择方式
//    
//    [self.image1 sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:@"default"] options:SDWebImageRetryFailed];
//    /*
//     //失败后重试
//     SDWebImageRetryFailed = 1 << 0,
//     
//     //UI交互期间开始下载，导致延迟下载比如UIScrollView减速。
//     SDWebImageLowPriority = 1 << 1,
//     
//     //只进行内存缓存
//     SDWebImageCacheMemoryOnly = 1 << 2,
//     
//     //这个标志可以渐进式下载,显示的图像是逐步在下载
//     SDWebImageProgressiveDownload = 1 << 3,
//     
//     //刷新缓存
//     SDWebImageRefreshCached = 1 << 4,
//     
//     //后台下载
//     SDWebImageContinueInBackground = 1 << 5,
//     
//     //NSMutableURLRequest.HTTPShouldHandleCookies = YES;
//     
//     SDWebImageHandleCookies = 1 << 6,
//     
//     //允许使用无效的SSL证书
//     //SDWebImageAllowInvalidSSLCertificates = 1 << 7,
//     
//     //优先下载
//     SDWebImageHighPriority = 1 << 8,
//     
//     //延迟占位符
//     SDWebImageDelayPlaceholder = 1 << 9,
//     
//     //改变动画形象
//     SDWebImageTransformAnimatedImage = 1 << 10,
//     */
    
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
