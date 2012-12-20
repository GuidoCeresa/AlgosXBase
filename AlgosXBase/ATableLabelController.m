//
//  ATableLabelControllerViewController.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 1-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "ATableLabelController.h"
#import "AlgosLibPList.h"
#import "AlgosLibView.h"
#import "Const.h"
#import "AlgosBorderLabel.h"
#import "AFormInfoController.h"

@interface ATableLabelController ()

@end

//--Tavola che utilizza i metodi e le regolazioni di default della superclasse
//--Costruisce una tavola con valori di testo (Label) per ogni record
//--L'altezza delle singole label ed il numero di righe per ogni label vengono calcolate
//--Aggiunge il titolo (obbligatorio)
//--Aggiunge un header (opzionale)
//--Mostra i numeri progressivi a sinistra (opzionale)
@implementation ATableLabelController


#pragma mark - Constants
//--Identificatore del segue tra opzioni e la web view specializzata, nello storyboard
static NSString *kSegueInfo = @"segueInfo";

#pragma mark - Local Variables
//--costanti della classe
NSString *kMostraNumeri = @"mostraNumeri";
NSString *kNumeroIniziale = @"numeroIniziale";
NSString *kCellIdentifier = @"labelCell";

//--mostra anche i numeri
BOOL mostraNumeri = false;
int numeroIniziale = 0;
int defaultNumeroIniziale = 1;
int larghezzaColonnaNumeri = 30;

#pragma mark - Init View
- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Table view data source
//--chiamata dal sistema ogni volta che deve disegnare una riga
//--la PrototypeCell dello storyboard è vuota
//--la label viene creata qui nel codice
//--la chiave per recuperare la cella dallo storyboard DEVE essere "labelCell"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSString *identifier = kCellIdentifier;
    AlgosBorderLabel *labelText;
    AlgosBorderLabel *labelNumber;

    //--se è già stata usata, recupera la cella
    cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
    //--Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    //--crea la label con le esatte dimensioni per il testo
    labelText = [self creaLabelTesto:indexPath.row];
    labelNumber = [self creaLabelNumber:indexPath.row];
    
    //--attacca la label alla cella
    [cell.contentView addSubview:labelText];
    [cell.contentView addSubview:labelNumber];
    
    //--aggiunge un sfondo grigio alternato
    if (indexPath.row%2 == 0) {
        labelText.backgroundColor = [Const instance].grigioScuro;
        labelNumber.backgroundColor = [Const instance].grigioScuro;
    } else {
        labelText.backgroundColor = [Const instance].grigioChiaro;
        labelNumber.backgroundColor = [Const instance].grigioChiaro;
       // labelText.backgroundColor = [UIColor yellowColor];
       // labelNumber.backgroundColor = [UIColor redColor];
    }
    
    //--restituisce al sistema la cella configurata
    return cell;
}

//--crea la label con le esatte dimensioni per il testo
- (AlgosBorderLabel *)creaLabelTesto:(int)indiceRiga {
    AlgosBorderLabel *label;
    NSString *testo;
    CGRect labelFrame;

    //--recupera il testo per questa riga/cella, dai dati
    testo = [myData objectAtIndex:indiceRiga];

    if (mostraNumeri) {
        label = [AlgosLibView creaLabelWithTesto:testo larga:[[NSNumber alloc] initWithInt:320-larghezzaColonnaNumeri]];
        label.leftInset = 5;
        labelFrame = label.frame;
        labelFrame.origin.x = labelFrame.origin.x + larghezzaColonnaNumeri;
        label.frame = labelFrame;
    } else {
        label = [AlgosLibView creaLabelWithTesto:testo];
    }

    //--regola il testo
    label.text = testo;

    return label;
}

//--crea la label con le esatte dimensioni per il numero
- (AlgosBorderLabel *)creaLabelNumber:(int)indiceRiga {
    AlgosBorderLabel *label;
    NSString *testo;
    CGRect labelFrame;
    int numero;
    
    if (mostraNumeri) {
        //--calcola il numero - di solito ascendente iniziando da zero od uno
        if (numeroIniziale > 1) {
            numero = numeroIniziale - indiceRiga;
        } else {
            numero = numeroIniziale + indiceRiga;
        }
    
        //--recupera il testo per questa riga/cella, dai dati
        testo = [myData objectAtIndex:indiceRiga];
    
        label = [AlgosLibView creaLabelWithTesto:testo larga:[[NSNumber alloc] initWithInt:320-larghezzaColonnaNumeri]];
        labelFrame = label.frame;
        labelFrame.size.width = larghezzaColonnaNumeri;
        label.frame = labelFrame;
    
        //--regola il testo
        [label setFont:[UIFont boldSystemFontOfSize:20]];
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        [label setText:[NSString stringWithFormat:@"%d",numero]];
    }
    return label;
}


//--chiamata dal sistema ogni volta che deve disegnare una riga
//--utilizza (tramite delega) lo stesso metodo usato per dimensionare la label della cella
//--calcola l'altezza esatta della label che contiene il testo
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (mostraNumeri) {
        return [AlgosLibView altezzaLabelWithTesto:[myData objectAtIndex:indexPath.row] larga:[[NSNumber alloc] initWithInt:320-larghezzaColonnaNumeri]];
    } else {
        return [AlgosLibView altezzaLabelWithTesto:[myData objectAtIndex:indexPath.row]];
    }
}

#pragma mark - View Edit
//--Bottone info nella barra di navigazione--
- (IBAction)openInfoScheda:(id)sender {
    NSString *identifier = kSegueInfo;
    
    @try {
        [self performSegueWithIdentifier:identifier sender:self];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

#pragma mark - View delegate
//--dopo aver selezionato il segue, passa di qui per eventuali regolazioni--
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
    if ([[segue identifier] isEqualToString:kSegueInfo]) {
        AFormInfoController *destViewController = segue.destinationViewController;
        destViewController.nomeInfoFile = nomeFilePList;
    }
}

#pragma mark - Utilitie methods
//--utilizzo dei numeri
//--numero iniziale: zero o uno di solito
- (void)setUpNumeri {
    NSNumber *numeroInizialeTmp;
    NSDictionary *dict = [super getDictionary];
    
    if (dict) {
        mostraNumeri = [AlgosLibPList boolValueFromDict:dict forKey:kMostraNumeri];
        numeroInizialeTmp = [dict objectForKey:kNumeroIniziale];
    }
    
    if (numeroInizialeTmp) {
        numeroIniziale = [numeroInizialeTmp integerValue];
    } else {
        numeroIniziale = defaultNumeroIniziale;
    }
}

@end
