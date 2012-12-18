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
    DescVal *descVal;
    NSObject *obj;
    
    static NSString *CellIdentifier = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    obj = [opzioni objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[DescVal class]]) {
        descVal = (DescVal *)obj;
        //cell.textLabel.text = descVal.descrizione;
        cell.textLabel.text = [self getTestoFromRiga:indexPath.row];
        cell.detailTextLabel.text = descVal.detail;
        
        if ([descVal.descrizione isEqualToString:valoreSelezionato]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
  
    return cell;
}

#pragma mark - Table Edit
//--selezionata una riga della tabella--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *valoreSelezionato;
    valoreSelezionato = [self getTestoFromRiga:indexPath.row];
    [self.delegate detailViewTerminated:valoreSelezionato];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Utility methods
- (NSString *)getTestoFromRiga:(NSUInteger *)riga {
    NSString *testo;
 //   NSInteger riga = [self.tableView indexPathForSelectedRow].row;
    NSObject *obj;
    DescVal *descVal;
 
    if (opzioni) {
        obj = [opzioni objectAtIndex:riga];

        if ([obj isKindOfClass:[DescVal class]]) {
            descVal = (DescVal *)obj;
            testo = descVal.descrizione;
        }
    }
    return testo;
}


@end
