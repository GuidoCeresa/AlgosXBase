//
//  AlgosTableController.h
//  AlgosXBase
//
//  Created by Guido Ceresa on 29-11-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATableController : UITableViewController
{
    NSArray *myData;
    BOOL usaHeader;
    BOOL usaFooter;
    BOOL usaTextFooter;
    BOOL usaViewFooter;
    BOOL usaGrigiAlternati;
    NSString *titolo;

    NSString *titoloFinestra;
    NSString *nomeFilePList;
    NSString *testoHeader;
    NSString *testoFooter;
}

@property (nonatomic, retain) NSArray *myData;
@property (nonatomic) BOOL usaHeader;
@property (nonatomic) BOOL usaFooter;
@property (nonatomic) BOOL usaTextFooter;
@property (nonatomic) BOOL usaViewFooter;
@property (nonatomic) BOOL usaGrigiAlternati;
@property (nonatomic, retain) NSString *titolo;

@property (nonatomic, retain) NSString *titoloFinestra;
@property (nonatomic, retain) NSString *nomeFilePList;
@property (nonatomic, retain) NSString *testoHeader;
@property (nonatomic, retain) NSString *testoFooter;

- (void)initVariables;
- (void)setTestoHeader:(NSString *)testo;
- (void)setTextFooterOnly:(NSString *)testo;
- (void)setTexFooterAndView:(NSString *)testo;
- (NSDictionary *)getDictionary;

@end
