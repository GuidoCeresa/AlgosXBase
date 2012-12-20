 //
//  ATableDetailController.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 3-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "ATableDetailController.h"
#import "DescVal.h"

@interface ATableDetailController ()

@end


@implementation ATableDetailController

#pragma mark - Synthesize Variables
//--delegate standard
@synthesize delegate;
//--array di tipo DescVal
@synthesize opzioni;
//--valore selezionato (eventuale)
@synthesize valoreSelezionato;


#pragma mark - Init View
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view group section
// Return the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [opzioni count];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *descrizione;
    NSString *detail;
    DescVal *descVal;
    NSObject *obj;
    NSDictionary *dict;
    
    static NSString *cellIdentifier = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    obj = [opzioni objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[DescVal class]]) {
        descVal = (DescVal *)obj;
        descrizione = descVal.descrizione;
        detail = descVal.detail;        
    }
  
    if ([obj isKindOfClass:[NSDictionary class]]) {
        dict = (NSDictionary *)obj;

        if ([dict objectForKey:@"nomeParametro"]) {
            descrizione = [dict objectForKey:@"nomeParametro"];
        }
        if ([dict objectForKey:@"dettaglioParametro"]) {
            detail = [dict objectForKey:@"dettaglioParametro"];
        }
    }

    if ([descrizione isEqualToString:valoreSelezionato]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    cell.textLabel.text = descrizione;
    cell.detailTextLabel.text = detail;
    
    return cell;
}

#pragma mark - Table Edit
//--selezionata una riga della tabella--
//--rimanda indietro il valore selezionato
//--chiude la vista
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *valSelezionato;
    valSelezionato = [self getTestoFromRiga:indexPath.row];
    if (valSelezionato) {
        [self.delegate detailViewTerminated:valSelezionato];
    }
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Utility methods
//--deprecated
- (NSString *)getTestoFromRiga:(NSUInteger)riga {
    NSString *testo;
 //   NSInteger riga = [self.tableView indexPathForSelectedRow].row;
    NSObject *obj;
    DescVal *descVal;
    NSDictionary *dict;
    
    if (opzioni) {
        obj = [opzioni objectAtIndex:riga];

        if ([obj isKindOfClass:[DescVal class]]) {
            descVal = (DescVal *)obj;
            testo = descVal.descrizione;
        }

        if ([obj isKindOfClass:[NSDictionary class]]) {
            dict = (NSDictionary *)obj;
            
            if ([dict objectForKey:@"nomeParametro"]) {
                testo = [dict objectForKey:@"nomeParametro"];
            }
        }
    }
    return testo;
}


@end
