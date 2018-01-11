//
//  RootViewController.m
//  Card Box
//
//  Created by Koldo Ruiz on 20/05/13.
//
//

#import "RootViewController.h"
#import "AddRecipeViewController.h"
#import "Recipes.h"
#import "ImageZoomViewController.h"
#import <QuartzCore/QuartzCore.h>



@interface RootViewController(Private)

@end

int separador;
int cambiador=0;
int cambiadorfondo=0;
int volteador;
NSTimer *tiempoCambio;
NSTimer *tiempoFlip;

@implementation RootViewController

@synthesize fetchedResultsController, managedObjectContext;


@synthesize contentView;

@synthesize etiqueta;

@synthesize imagenContador, fondoMesa, tarjeteroInferior;

@synthesize buttonAdd, buttonFlip, buttonchange, elsalvador , imagenbutton1, imagenbutton2;



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* languages = [NSLocale preferredLanguages];
    NSString* preferredLang = [languages objectAtIndex:0];
    
    //Inicializa a 0 variable INT que sirve para saber si las fotos estan de frente o dadas la vuelta.
    volteador=0;
    
    
    //este if controla si estamos utilizando la app en un iphone o en un iphone 5 y realiza los ajustes convenientes
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            tarjeteroInferior.frame = CGRectMake(0,0, 320, 480);
            fondoMesa.frame= CGRectMake(0,0, 320, 480);
        }
        if(result.height == 568)
        {
            tarjeteroInferior.frame = CGRectMake(0,0, 320, 570);
            CGRect frame = [buttonAdd frame];
            frame.origin.y += 85;
            [buttonAdd setFrame:frame];
            
            CGRect frame2 = [buttonFlip frame];
            frame2.origin.y += 85;
            [buttonFlip setFrame:frame2];
            
            CGRect frame3 = [etiqueta frame];
            frame3.origin.y += 85;
            [etiqueta setFrame:frame3];
            
            CGRect frame4 = [imagenContador frame];
            frame4.origin.y += 85;
            [imagenContador setFrame:frame4];
            
            CGRect frame5 = [buttonchange frame];
            frame5.origin.y += 85;
            [buttonchange setFrame:frame5];
            
            CGRect frame6 = [elsalvador frame];
            frame6.origin.y += 85;
            [elsalvador setFrame:frame6];
            
            CGRect frame7 = [imagenbutton1 frame];
            frame7.origin.y += 85;
            [imagenbutton1 setFrame:frame7];
            
            CGRect frame8 = [imagenbutton2 frame];
            frame8.origin.y += 85;
            [imagenbutton2 setFrame:frame8];
            
            

        }
    }

    
    
    
    

    //Coloca el titulo dependiendo del idioma configurado en el teléfono.
    //   español -->  es   ingles -->  en
    if([preferredLang isEqual:@"es"])
    {
	self.title = @"Mis Tarjetas";
    }
    else{
        self.title = @"My Cards";
    }
	//Set up the edit and add buttons.
    /*self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem.title=@"Edit";
    self.view.backgroundColor=[UIColor clearColor]; */
    
    
    self.navigationController.navigationBarHidden=YES;
   /* UIBarButtonItem *opciones = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks  target:self action:@selector(opcion)];
	self.navigationItem.leftBarButtonItem = opciones;
    opciones.title=@"Opciones";
	[opciones release]; */
    
    
   /* UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release]; */
    
   // UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo"]];
    //[tempImageView setFrame:self.tableView.frame];
    
   // self.tableView.backgroundView = tempImageView;
    //[tempImageView release];
    
    self.tableView.backgroundColor=[UIColor clearColor];
    
    
    //Coloca el numero de tarjetas en el label de la view
    NSString *theValue = [NSString stringWithFormat:@"%d", separador];
    etiqueta.text = theValue;
   
    
    
    
    
    
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    
    
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		//NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
    NSString *theValue = [NSString stringWithFormat:@"%d", separador];
    etiqueta.text = theValue;
    
    
   
}



//esconde la barra de navegacion al comenzar el view
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
     self.navigationController.navigationBarHidden=YES;
     
     
}


 - (void)viewWillDisappear:(BOOL)animated {
     [super viewWillDisappear:animated];

     
  }
 
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

- (void)viewDidUnload {
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Add a new object



- (void)insertNewObject {
    

    
	/* AddRecipeViewController *addRecipeView = [[AddRecipeViewController alloc] initWithNibName:@"AddRecipeViewController" bundle:[NSBundle mainBundle]];
	Recipes *recipes = (Recipes *)[NSEntityDescription insertNewObjectForEntityForName:@"Recipes" inManagedObjectContext:self.managedObjectContext];
	addRecipeView.recipes = recipes;
    
    
    
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: addRecipeView];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
           [self.navigationController presentViewController:navController animated:YES completion:nil];
        }
        if(result.height == 568)
        {
          [self.navigationController presentViewController:navController animated:NO completion:nil];
        }
    }
	[addRecipeView release];  */
    
    
    
    
    
}


#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    separador= [sectionInfo numberOfObjects];
    return [sectionInfo numberOfObjects];
    
     
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	Recipes *recipes = [fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = recipes.recipeName;
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.shadowColor=[UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:37];
    cell.textLabel.shadowOffset = CGSizeMake(0, 1);
    cell.textLabel.bounds= CGRectMake(70, 0, 300, 120);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
 
    
        
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    cell.backgroundColor=[UIColor clearColor];
    UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 277, 150)];
    [av.layer setCornerRadius:12.0f];
    [av.layer setMasksToBounds:YES];
    av.backgroundColor = [UIColor clearColor];
    av.opaque = NO;
    
    if(volteador==0)
    {
        av.image = [recipes.recipeImage valueForKey:@"recipeImage"];
    }
    else
    {
        av.image=recipes.recipeThumbnailImage;
    }
    
    
    if (av.image.size.height>av.image.size.width)
    {
        av.transform = CGAffineTransformMakeRotation(3.14/2);
    }
    cell.backgroundView = av;
    
    [av setContentMode:UIViewContentModeScaleAspectFit];
    

       
      /*UIView *cellSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320 ,40)];
    [cellSeparator setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleWidth];
    [cellSeparator setContentMode:UIViewContentModeTopLeft];
    [cellSeparator.layer setMasksToBounds:YES];
    //[cellSeparator.layer setCornerRadius:8.0f];
    [cellSeparator setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]]];
    [cell addSubview:cellSeparator];
    [cellSeparator release];   */
     

    
    return cell;
}



//Funcion que te lleva al visor de tarjetas individual
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageZoomViewController *zView = [[ImageZoomViewController alloc] initWithNibName:@"ImageZoomViewController" bundle:[NSBundle mainBundle]];
	Recipes *recipes = (Recipes *)[fetchedResultsController objectAtIndexPath:indexPath];
	zView.recipes = recipes;
	[self.navigationController pushViewController:zView animated:YES]; 
    
    
}


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
     return YES;

 }
 


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
		[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
        
        
		[self.tableView reloadData];
        NSString *theValue = [NSString stringWithFormat:@"%d", separador];
        etiqueta.text = theValue;
		// Save the context.
		NSError *error = nil;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			//NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}   
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
	 Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"recipeName" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    
    aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	return fetchedResultsController;
}    


// NSFetchedResultsControllerDelegate method to notify the delegate that all section and object changes have been processed. 
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// In the simplest, most efficient, case, reload the table view.
	[self.tableView reloadData];
    NSString *theValue = [NSString stringWithFormat:@"%d", separador];
    etiqueta.text = theValue;
}

/*
 Instead of using controllerDidChangeContent: to respond to all changes, you can implement all the delegate methods to update the table view in response to individual changes.  This may have performance implications if a large number of changes are made simultaneously.
 
 // Notifies the delegate that section and object changes are about to be processed and notifications will be sent. 
 - (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
 [self.tableView beginUpdates];
 }
 
 - (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
 // Update the table view appropriately.
 }
 
 - (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
 // Update the table view appropriately.
 }
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 [self.tableView endUpdates];
 } 
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	// Relinquish ownership of any cached data, images, etc that aren't in use.
}


- (void)dealloc {
	[fetchedResultsController release];
	[managedObjectContext release];
    [super dealloc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}


//cambia el letrero de borrar segun el idioma
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* languages = [NSLocale preferredLanguages];
    NSString* preferredLang = [languages objectAtIndex:0];
    
    if([preferredLang isEqual:@"es"])
    {
        return @"Borrar";
    }
    else{
        return @"Delete";
    }
    
    
}


//Inserta Nuevo objeto, esta funcion se active al hacer click en el boton +
-(IBAction)nueva:(id)sender
{
        
        AddRecipeViewController *addRecipeView = [[AddRecipeViewController alloc] initWithNibName:@"AddRecipeViewController" bundle:[NSBundle mainBundle]];
        Recipes *recipes = (Recipes *)[NSEntityDescription insertNewObjectForEntityForName:@"Recipes" inManagedObjectContext:self.managedObjectContext];
        addRecipeView.recipes = recipes;
    
    
    
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: addRecipeView];
        [self.navigationController presentViewController:navController animated:YES completion:nil];
        [addRecipeView release];
    
}


//funcion que se encarga de dar la vuelta a las tarjetas cuando presionamos el boton inferior izquierdo
-(IBAction)voltio:(id)sender
{
    //etiqueta.hidden=YES;
   if(volteador==0)
   {
       volteador++;
       
       UIImage *XImage = [UIImage imageNamed:@"contadorblanco"];
       [UIView transitionWithView:imagenContador duration:0.5
                          options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                              imagenContador.image = XImage;
                          } completion:nil];
       
     //  etiqueta.textColor=[UIColor whiteColor];
     //  etiqueta.shadowColor=[UIColor blackColor];
       
   }
   else{
       volteador=0;
       
       UIImage *YImage = [UIImage imageNamed:@"contadorfrontal"];
       [UIView transitionWithView:imagenContador duration:0.5
                          options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                              imagenContador.image = YImage;
                          } completion:nil];

       
   }
    
    
    
    [self.tableView reloadData];    
    
}


//funcion que se encarga de cambiar el fondo
-(IBAction)boxChange:(id)sender{
    buttonFlip.hidden=YES;
    buttonAdd.hidden=YES;
    etiqueta.hidden=YES;
    imagenContador.hidden=YES;
    buttonchange.hidden=YES;
    imagenbutton1.hidden=YES;
    imagenbutton2.hidden=YES;
    self.tableView.hidden=YES;
    
    tiempoCambio=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backToNormal) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:tiempoCambio forMode:NSRunLoopCommonModes];
    if(cambiador==0)
    {
    tarjeteroInferior.image=[UIImage imageNamed:@"cuero"];
    fondoMesa.image=[UIImage imageNamed:@"cuerofondo"];
        [UIView transitionWithView:fondoMesa duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               fondoMesa.image = fondoMesa.image;
                           } completion:nil];
        
        
        [UIView transitionWithView:tarjeteroInferior duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               tarjeteroInferior.image = tarjeteroInferior.image;
                           } completion:nil];
    }
    if(cambiador==1)
    {
        tarjeteroInferior.image=[UIImage imageNamed:@"tarjeteronegro"];
        fondoMesa.image=[UIImage imageNamed:@"fondonegro"];
        [UIView transitionWithView:fondoMesa duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               fondoMesa.image = fondoMesa.image;
                           } completion:nil];
        
        [UIView transitionWithView:tarjeteroInferior duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               tarjeteroInferior.image = tarjeteroInferior.image;
                           } completion:nil];
    }
    
    if(cambiador==2)
    {
        tarjeteroInferior.image=[UIImage imageNamed:@"tarjeteroverde"];
        fondoMesa.image=[UIImage imageNamed:@"fondoverde"];
        [UIView transitionWithView:fondoMesa duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               fondoMesa.image = fondoMesa.image;
                           } completion:nil];
        
        [UIView transitionWithView:tarjeteroInferior duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               tarjeteroInferior.image = tarjeteroInferior.image;
                           } completion:nil];
    }
    if(cambiador==3)
    {
        tarjeteroInferior.image=[UIImage imageNamed:@"tarjeteromorado"];
        fondoMesa.image=[UIImage imageNamed:@"fondomorado"];
        [UIView transitionWithView:fondoMesa duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               fondoMesa.image = fondoMesa.image;
                           } completion:nil];
        
        [UIView transitionWithView:tarjeteroInferior duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               tarjeteroInferior.image = tarjeteroInferior.image;
                           } completion:nil];
    }
    
    if (cambiador==4)
    {
        tarjeteroInferior.image=[UIImage imageNamed:@"tarjetero"];
        fondoMesa.image=[UIImage imageNamed:@"fondo"];
        [UIView transitionWithView:fondoMesa duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               fondoMesa.image = fondoMesa.image;
                           } completion:nil];
        
        [UIView transitionWithView:tarjeteroInferior duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               tarjeteroInferior.image = tarjeteroInferior.image;
                           } completion:nil];
        cambiador=-1;
    }
    cambiador++;
  
    
    
    
}


//funcion que restablece todos los botones al hacer el cambio de tarjetero
- (void)backToNormal{
    buttonFlip.hidden=NO;
    buttonAdd.hidden=NO;
    etiqueta.hidden=NO;
    imagenContador.hidden=NO;
    buttonchange.hidden=NO;
    imagenbutton1.hidden=NO;
    imagenbutton2.hidden=NO;
    self.tableView.hidden=NO;
    if ([tiempoCambio isValid]) {
        [tiempoCambio invalidate];
    }
}



@end

