//
//  RootViewController.h
//  Card Box
//
//  Created by Koldo Ruiz on 20/05/13.
//
//

#import <UIKit/UIKit.h>





@interface RootViewController : UIViewController <NSFetchedResultsControllerDelegate,UITableViewDelegate, UITableViewDataSource> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
    UIView *contentView;
    UITableView * tableView;
    
}



@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UILabel *etiqueta;

@property (nonatomic, retain) IBOutlet UIImageView *imagenContador;

@property (nonatomic, retain) IBOutlet UIImageView *tarjeteroInferior;
@property (nonatomic, retain) IBOutlet UIImageView *fondoMesa;

@property (nonatomic, retain) IBOutlet UIButton *buttonAdd;

@property (nonatomic, retain) IBOutlet UIButton *buttonFlip;

@property (nonatomic, retain) IBOutlet UIButton *buttonchange;

@property (nonatomic, retain) IBOutlet UIButton *elsalvador;


@property (nonatomic, retain) IBOutlet UIImageView *imagenbutton1;

@property (nonatomic, retain) IBOutlet UIImageView *imagenbutton2;





- (IBAction)nueva:(id)sender;

-(IBAction)voltio:(id)sender;

-(IBAction)boxChange:(id)sender;

@end

