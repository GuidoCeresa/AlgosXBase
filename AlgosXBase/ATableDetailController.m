 //
//  ATableDetailController.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 3-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "ATableDetailController.h"
#import "DescVal.h"
#import "AlgosBorderLabel.h"

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

#pragma mark - Local constants
static BOOL debug = false;
static int kAltRigaNormale = 45;
static int kTopInset2 = 0;
static int kAltLabelDescrizione2 = 30;
static int kAltSpazioLabel2 = 0;
static int kAltLabelDetailImmagine = 70;
static int kBottomInset2 = 5;

#pragma mark - Local Variables
int altezzaCellaDetail;


#pragma mark - Init View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //--regola l'altezza della cella
    altezzaCellaDetail = kTopInset2 + kAltLabelDescrizione2 + kAltSpazioLabel2 + kAltLabelDetailImmagine + kBottomInset2;
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
    UITableViewCell *cell;
    NSString *descrizione;
    NSString *detail;
    NSString *nomeImmagine;
    DescVal *descVal;
    NSObject *obj;
    NSDictionary *dict;
    UIView *cellView;    
    NSInteger riga = indexPath.row;
   
    static NSString *cellIdentifier = @"detailCell";
    static NSString *cellIdentifierCustom = @"detailCustomCell";
    
    //cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierCustom forIndexPath:indexPath];
    
    obj = [opzioni objectAtIndex:riga];
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
        if ([dict objectForKey:@"nomeImmagine"]) {
            nomeImmagine = [dict objectForKey:@"nomeImmagine"];
        }
    }

    if ([cell.contentView subviews]) {
        for (UIView *subView in [cell.contentView subviews]) {
            [subView removeFromSuperview];
        }
    }

    //--Configure the cell...
    if (cell == nil) {
        if (detail.length < 10) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//            cell.textLabel.text = descrizione;
//            cell.detailTextLabel.text = detail;
            cellView = [self elaboraCellaWithRiga:riga descrizione:descrizione detail:detail];
            [cell.contentView addSubview:cellView];
          
            if ([descrizione isEqualToString:valoreSelezionato]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierCustom];
            cellView = [self elaboraCellaWithRiga:riga descrizione:descrizione detail:detail nomeImmagine:nomeImmagine];
            [cell.contentView addSubview:cellView];
        }
    }
    
    //--restituisce al sistema la cella configurata
    return cell;
}

//--Elabora la view interna della cella
//--Disegna la view
- (UIView *)elaboraCellaWithRiga:(int)riga descrizione:(NSString *)descrizione detail:(NSString *)detail {
    UIView *cellView = [[UIView alloc] init];
    AlgosBorderLabel *labelDescrizione;
    AlgosBorderLabel *labelDetail;
    
    labelDescrizione = [self creaLabelDescrizioneSinistra:descrizione];
    labelDetail = [self creaLabelDetailLaterale:detail];
    [cellView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [cellView addSubview:labelDescrizione];
    [cellView addSubview:labelDetail];
    
    return cellView;
}


//--Elabora la view interna della cella
//--Disegna la view
- (UIView *)elaboraCellaWithRiga:(int)riga descrizione:(NSString *)descrizione detail:(NSString *)detail nomeImmagine:(NSString *)nomeImmagine {
    UIView *cellView = [[UIView alloc] init];
    NSString *pathImmagine;
    AlgosBorderLabel *labelDescrizione;
    AlgosBorderLabel *labelDetail;
    UIImage *image;
    CGRect imageFrame = CGRectMake(200, kTopInset2, 100, kAltLabelDescrizione2 + kAltSpazioLabel2 + kAltLabelDetailImmagine);
    UIImageView *imageView ;

    if (nomeImmagine) {
        pathImmagine = [[NSBundle mainBundle] pathForResource:nomeImmagine ofType:@"png"];
        image = [UIImage imageWithContentsOfFile:pathImmagine];
    }
    
    if (image) {
        imageView = [[UIImageView alloc] initWithFrame:imageFrame];
        [imageView setImage:image];
    }
    labelDescrizione = [self creaLabelDescrizioneAlta:descrizione];
    labelDetail = [self creaLabelDetailSotto:detail];
    [cellView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [cellView addSubview:labelDescrizione];
    [cellView addSubview:labelDetail];
    [cellView addSubview:imageView];

    return cellView;
}


//--Crea la label per la descrizione della opzione
- (AlgosBorderLabel *)creaLabelDescrizioneSinistra:(NSString *)testo {
    AlgosBorderLabel *label;
    CGRect labelFrame = CGRectMake(10, kTopInset2, 200, kAltRigaNormale);
    
    label = [[AlgosBorderLabel alloc] initWithFrame:labelFrame];
    [label setBackgroundColor:[UIColor clearColor]];
    if (debug) {[label setBackgroundColor:[UIColor greenColor]];}
    label.textAlignment = NSTextAlignmentLeft;
    [label setFont:[UIFont boldSystemFontOfSize:17.0]];
    [label setText:testo];
    
    return label;
}

//--Crea la label per la descrizione della opzione
- (AlgosBorderLabel *)creaLabelDescrizioneAlta:(NSString *)testo {
    AlgosBorderLabel *label;
    CGRect labelFrame = CGRectMake(10, kTopInset2, 200, kAltLabelDescrizione2);
    
    label = [[AlgosBorderLabel alloc] initWithFrame:labelFrame];
    [label setBackgroundColor:[UIColor clearColor]];
    if (debug) {[label setBackgroundColor:[UIColor greenColor]];}
    label.textAlignment = NSTextAlignmentLeft;
    [label setFont:[UIFont boldSystemFontOfSize:17.0]];
    [label setText:testo];
    
    return label;
}

//--Crea la label per il dettaglio della opzione
- (AlgosBorderLabel *)creaLabelDetailLaterale:(NSString *)testo {
    AlgosBorderLabel *label;
    CGRect labelFrame = CGRectMake(200, kTopInset2, 70, kAltRigaNormale);
    
    label = [[AlgosBorderLabel alloc] initWithFrame:labelFrame];
    label.numberOfLines = 0;
    [label setBackgroundColor:[UIColor clearColor]];
    if (debug) {[label setBackgroundColor:[UIColor redColor]];}
    label.textAlignment = NSTextAlignmentRight;
    [label setFont:[UIFont italicSystemFontOfSize:15.0]];
    [label setText:testo];
    
    return label;
}

//--Crea la label per il dettaglio della opzione
- (AlgosBorderLabel *)creaLabelDetailSotto:(NSString *)testo {
    AlgosBorderLabel *label;
    CGRect labelFrame = CGRectMake(10, kTopInset2 + kAltLabelDescrizione2 + kAltSpazioLabel2, 200, kAltLabelDetailImmagine);
    
    label = [[AlgosBorderLabel alloc] initWithFrame:labelFrame];
    label.numberOfLines = 0;
    [label setBackgroundColor:[UIColor clearColor]];
    if (debug) {[label setBackgroundColor:[UIColor redColor]];}
    label.textAlignment = NSTextAlignmentLeft;
    [label setFont:[UIFont italicSystemFontOfSize:15.0]];
    [label setText:testo];
    
    return label;
}

//--chiamata dal sistema ogni volta che deve disegnare una riga
//--utilizza (tramite delega) lo stesso metodo usato per dimensionare la label della cella
//--calcola l'altezza esatta della label che contiene il testo
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self getAltezzaRiga:indexPath.row];
}

#pragma mark - Table Edit
//--selezionata una riga della tabella--
//--rimanda indietro il valore selezionato
//--chiude la vista
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *valSelezionato;
    valSelezionato = [self getDescrizioneFromRiga:indexPath.row];
    if (valSelezionato) {
        [self.delegate detailViewTerminated:valSelezionato];
    }
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Utility methods
- (NSString *)getDescrizioneFromRiga:(NSUInteger)riga {
    NSString *testo;
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

- (NSString *)getDetailFromRiga:(NSUInteger)riga {
    NSString *testo;
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
            
            if ([dict objectForKey:@"dettaglioParametro"]) {
                testo = [dict objectForKey:@"dettaglioParametro"];
            }
        }
    }
    return testo;
}

- (int)getAltezzaRiga:(NSUInteger)riga {
    int altezza;
    NSString *detail = [self getDetailFromRiga:riga];
    
    if (detail.length < 10) {
        altezza = kAltRigaNormale;
    } else {
        altezza = altezzaCellaDetail;
    }
    return altezza;
}

@end
