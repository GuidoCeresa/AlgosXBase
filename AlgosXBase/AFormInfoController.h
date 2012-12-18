//
//  AFormInfoController.h
//  AlgosXBase
//
//  Created by Guido Ceresa on 18-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFormInfoController : UIViewController <UIWebViewDelegate> {
    NSString *nomeInfoFile;
	IBOutlet UIWebView* web;
}

@property (nonatomic, retain) IBOutlet UIWebView* web;
@property (nonatomic, retain) NSString *nomeInfoFile;

@end
