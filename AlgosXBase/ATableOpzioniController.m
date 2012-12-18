//
//  ATableOpzioniController.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 2-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "ATableOpzioniController.h"
#import "ATableDetailController.h"
#import "AlgosBorderLabel.h"
#import "Const.h"
#import "AlgosLibView.h"
#import "DescVal.h"
#import "AFormInfoController.h"

@interface ATableOpzioniController ()

@end

//--Tavola che utilizza i metodi e le regolazioni di default della superclasse
//--Costruisce una tavola con n sezioni ognuna dei quali rimanda ad una serie di opzioni
//--Le opzioni vengono presentate in una sotto-Tavola
//--Aggiunge il titolo (obbligatorio)
//--Aggiunge un header (opzionale)
@implementation ATableOpzioniController


#pragma mark - Synthesize Variables
//--nomi delle sezioni = chiavi ordinate del dizionario parametri
@synthesize sezioni;

//--valori di tutti i parametri e delle opzioni per ciascuno
@synthesize parametri;

//--testo selezionato di ogni sezione
@synthesize testoSezioni;


#pragma mark - Constants
//--Nome del campo chiave interno al NSDictionary
static NSString *kValori = @"valori";

//--Identificatore del segue tra opzioni e la tavola specializzata, nello storyboard
static NSString *kSegueDetail = @"segueDetail";

//--Identificatore del segue tra opzioni e la web view specializzata, nello storyboard
static NSString *kSegueInfo = @"segueInfo";

//--Nome del campo chiave interno al NSDictionary
static NSString *kDettaglio = @"dettaglioParametro";

//--Nome del campo chiave interno al NSDictionary
static NSString *kNomeParametro = @"nomeParametro";

//--Nome del campo chiave interno al NSDictionary
static NSString *kValoreParametro = @"valoreParametro";

#pragma mark - Local Variables
//--costanti della classe
NSString *kCellIdentifier2 = @"opzioniCell";
int extraPrimaSezione = 10;
int altezzaNormaleSezione = 30;


#pragma mark - Init View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //--Regola inizialmente il testo selezionato di ogni sezione
    [self setUpTestoSezioni];
}

#pragma mark - Table view group section
//--Return the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sezioni count];
}

//--Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - Table view data source
//--chiamata dal sistema ogni volta che deve disegnare una riga
//--la PrototypeCell dello storyboard è vuota
//--la label viene creata qui nel codice
//--la chiave per recuperare la cella dallo storyboard DEVE essere "opzioni"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSString *identifier = kCellIdentifier2;
    AlgosBorderLabel *labelText;
    
    //--se è già stata usata, recupera la cella
    cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //--Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
        
    //--crea la label
    labelText = [self creaLabelTesto:[indexPath section]];
    //labelNumber = [self creaLabelNumber:indexPath.row];
    
    //--attacca la label alla cella
    if ([cell.contentView subviews]) {
        for (UIView *subView in [cell.contentView subviews]) {
            [subView removeFromSuperview];
        }
    }
    [cell.contentView addSubview:labelText];
    
    //--aggiunge un sfondo grigio alternato
    if (indexPath.row%2 == 0) {
        //labelText.backgroundColor = [Const instance].grigioScuro;
        //labelNumber.backgroundColor = [Const instance].grigioScuro;
    } else {
        //labelText.backgroundColor = [Const instance].grigioChiaro;
        //labelNumber.backgroundColor = [Const instance].grigioChiaro;
    }
    
    //--restituisce al sistema la cella configurata
    return cell;
}

//--crea la label
- (AlgosBorderLabel *)creaLabelTesto:(int)indiceSezione {
    AlgosBorderLabel *label;
    NSString *testo;
    CGRect labelFrame = CGRectMake(10, 0, 320, 30);
    
    testo = [testoSezioni objectAtIndex:indiceSezione];
    label = [[AlgosBorderLabel alloc] initWithFrame:labelFrame];
    [label setBackgroundColor:[UIColor clearColor]];
    label.textAlignment = NSTextAlignmentLeft;
    [label setFont:[UIFont systemFontOfSize:15.0]];
    [label setText:testo];
        
    return label;
}

//--chiamata dal sistema ogni volta che deve disegnare una riga
//--utilizza (tramite delega) lo stesso metodo usato per dimensionare la label della cella
//--calcola l'altezza esatta della label che contiene il testo
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return altezzaNormaleSezione;
}

#pragma mark - Table view sections header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   // return [myData objectAtIndex:section];
    //For each section, you must return here it's label
    if(section == 0) {
    }
    return [sezioni objectAtIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AlgosBorderLabel *label;
    NSString *titoloSezione;
    AlgosBorderLabel *labelDesc;
    labelDesc = [AlgosLibView creaLabelWithTesto:testoHeader];
    int altDescrizione = labelDesc.frame.size.height;

    CGRect firstLabelFrame = CGRectMake(0, altDescrizione + extraPrimaSezione, 320, altezzaNormaleSezione);
    CGRect normalLabelFrame = CGRectMake(0, 0, 320, altezzaNormaleSezione);
    CGRect currentLabelFrame;
    CGRect firstViewFrame = CGRectMake(0, 0, 320, altezzaNormaleSezione + altDescrizione + extraPrimaSezione);
    CGRect normalViewFrame = CGRectMake(0, 0, 320, altezzaNormaleSezione);
    CGRect currentViewFrame;

    if (section == 0) {
        currentLabelFrame = firstLabelFrame;
        currentViewFrame = firstViewFrame;
    } else {
        currentLabelFrame = normalLabelFrame;
        currentViewFrame = normalViewFrame;
    }
    
    //--recupera il testo per questa riga/cella, dai dati
    titoloSezione = [sezioni objectAtIndex:section];

    label = [[AlgosBorderLabel alloc] initWithFrameInsetDefault:currentLabelFrame];
    [label setBackgroundColor:[UIColor clearColor]];
    label.textAlignment = NSTextAlignmentLeft;
    [label setFont:[UIFont boldSystemFontOfSize:17.0]];
    [label setText:titoloSezione];
    //label.backgroundColor = [UIColor yellowColor];
    UIView *view = [[UIView alloc] initWithFrame:currentViewFrame];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    if (section == 0) {
        [view addSubview:labelDesc];
    }
    [view addSubview:label];

    //view.backgroundColor = [UIColor redColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
       return altezzaNormaleSezione + [AlgosLibView altezzaLabelWithTesto:testoHeader] + extraPrimaSezione;
    } else {
        return altezzaNormaleSezione;
    }
}

#pragma mark - Table Edit
//--selezionata una riga della tabella--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    @try {
  //    [self.navigationController performSegueWithIdentifier:kSegueDetail sender:nil];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
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


#pragma mark - Table view delegate
//--dopo aver selezionato il segue, passa di qui per eventuali regolazioni--
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSInteger riga = indexPath.section;
    NSString *nomeSezione;
    NSDictionary *dictParametri;
    NSMutableArray *arrayOpzioniTmp = [[NSMutableArray alloc] init];
    DescVal *descVal;
    NSObject *obj;
    NSDictionary *dicOpzione;
    NSString *key;
    NSString *val;
    NSString *valoreSelezionato;
    
    if ([[segue identifier] isEqualToString:kSegueDetail]) {
        nomeSezione = [sezioni objectAtIndex:riga];
        dicOpzione = [parametri objectForKey:nomeSezione];
        valoreSelezionato = [testoSezioni objectAtIndex:riga];
        
        for (obj in dicOpzione) {
            if ([obj isKindOfClass:[DescVal class]]) {
                descVal = (DescVal *)obj;
                [arrayOpzioniTmp addObject:descVal];
            }
            if ([obj isKindOfClass:[NSString class]]) {
                descVal = [[DescVal alloc] init];
                key = (NSString *)obj;
                val = [dicOpzione objectForKey:key];
                descVal.descrizione = key;
                //descVal.valore = [[NSNumber alloc] initWithInt:[val integerValue]];
                descVal.detail = val;
                [arrayOpzioniTmp addObject:descVal];
            }
            if ([obj isKindOfClass:[NSDictionary class]]) {
                descVal = [[DescVal alloc] init];
                dictParametri = (NSDictionary *)obj;
                if ([dictParametri objectForKey:kNomeParametro]) {
                    descVal.descrizione = [dictParametri objectForKey:kNomeParametro];
                }
                if ([dictParametri objectForKey:kDettaglio]) {
                    descVal.detail = [dictParametri objectForKey:kDettaglio];
                }
                if ([dictParametri objectForKey:kValoreParametro]) {
                    descVal.valore = [dictParametri objectForKey:kValoreParametro];
                }
                [arrayOpzioniTmp addObject:descVal];
            }
            descVal.check = false;
       }

        ATableDetailController *destViewController = segue.destinationViewController;
        destViewController.titoloFinestra = nomeSezione;
        destViewController.opzioni= arrayOpzioniTmp;
        destViewController.valoreSelezionato = valoreSelezionato;
        destViewController.delegate = self;
    }

    if ([[segue identifier] isEqualToString:kSegueInfo]) {
        AFormInfoController *destViewController = segue.destinationViewController;
        destViewController.nomeInfoFile = nomeFilePList;
    }
}

//--Ritorno da ATableDetail col valore selezionato
//--Regola il testo della opzione
- (void)detailViewTerminated:(NSString *)valoreSelezionato {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSInteger riga = indexPath.row;
    [testoSezioni replaceObjectAtIndex:riga withObject:valoreSelezionato];
    [self.tableView reloadData];
}

#pragma mark - Utility methods
//--reset di alcuni parametri--
//--Utilizzato solo dalle sottoclassi
- (void)resetInizialeParametri {
    parametri = nil;
    sezioni = nil;
    testoSezioni = nil;
}


//--Recupera le chiavi del dizionario che sono le sezioni da mostrare
//--Utilizzato solo dalla sottoclasse ATableOpzioni
//--Presuppone che lo schema della pList sia costituito da:
//--n dizionari (opzioni), ognuno contenente n dizionari (parametri)
//--L'ordine non è garantito
- (void)setUpSezioni {
    NSDictionary *dictRoot = [super getDictionary];
    NSDictionary *dictValori;
    
    if (dictRoot) {
        dictValori = [dictRoot objectForKey:kValori];
        if (dictValori) {
            sezioni = [dictValori allKeys];
        }
    }
}

//--Recupera le chiavi del dizionario che sono le sezioni da mostrare
//--Utilizzato solo dalla sottoclasse ATableOpzioni
//--Presuppone che lo schema della pList sia costituito da:
//--n dizionari (opzioni), ognuno contenente n dizionari (parametri)
//--L'ordine non è garantito
- (void)setUpTestoSezioni {
    testoSezioni = [[NSMutableArray alloc] init];
    NSString *valVuoto = @"... ...";
    
    if (sezioni) {
        for (NSString *key in sezioni) {
            [testoSezioni addObject:valVuoto];
        }
    }
}

//--recupera i valori di tutti i parametri
//--Utilizzato solo dalla sottoclasse ATableOpzioni
//--Presuppone che lo schema della pList sia costituito da:
//--n dizionari (opzioni), ognuno contenente n dizionari (parametri)
//--L'ordine non è garantito
- (void)setUpParametri {
    NSDictionary *dictRoot = [super getDictionary];
    NSDictionary *dicValori;
    NSArray *keys;
    NSMutableDictionary *tempParametri = [NSMutableDictionary dictionary];
    NSDictionary *dicOpzione;
    
    dicValori = [dictRoot objectForKey:kValori];
    keys = [dicValori allKeys];
    for (NSString *key in keys) {
        dicOpzione = [dicValori objectForKey:key];
        [tempParametri setObject:dicOpzione forKey:key];
    }
    parametri = tempParametri;
}

@end



