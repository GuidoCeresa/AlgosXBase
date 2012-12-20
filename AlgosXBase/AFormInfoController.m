//
//  AFormInfoController.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 18-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "AFormInfoController.h"

@interface AFormInfoController ()

@end

@implementation AFormInfoController

#pragma mark - Synthesize Variables
@synthesize nomeInfoFile;
@synthesize web;

#pragma mark - Constants

#pragma mark - Local Variables
//--colori di sfondo delle label
UIColor *grigioCeleste;

#pragma mark - Init View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //--recupera la pagina web
    if (nomeInfoFile) {
        [self setUpWeb];
    }
    
    //--sfondo
    //--colore di sfondo della finestra--
    grigioCeleste = [UIColor colorWithRed: 240.0/255.0 green: 245.0/255.0 blue:245.0/255.0 alpha: 1.0];
    [self.view setBackgroundColor:grigioCeleste];
}

#pragma mark - Utility methods
//--recupera la pagina web
- (void)setUpWeb {
    NSString *domain = @"http://www.algos.it/118/file/";
    domain = [domain stringByAppendingString:nomeInfoFile];
    domain = [domain stringByAppendingString:@".html"];
    NSURL *url = [NSURL URLWithString:domain];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [web loadRequest:requestURL];
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:requestURL];
}

@end
