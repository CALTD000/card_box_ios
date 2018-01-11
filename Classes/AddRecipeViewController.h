//
//  AddRecipeViewController.h
//  Card Box
//
//  Created by Koldo Ruiz on 20/05/13.
//
//

#import <UIKit/UIKit.h>

@class Recipes;

@interface AddRecipeViewController : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
	Recipes *recipes;
	UITextField *textFieldOne;
	UITextField *textFieldTwo;
	UIButton *photoButton;
    UIView *contentView;
}

@property (nonatomic, retain) Recipes *recipes;
@property (nonatomic, retain) IBOutlet UITextField *textFieldOne;
@property (nonatomic, retain) IBOutlet UITextField *textFieldTwo;
@property (nonatomic, retain) IBOutlet UIButton *photoButton;
@property (nonatomic, retain) IBOutlet UIImageView *tarjetas;


@property (nonatomic, retain) IBOutlet UIView *contentView;



- (IBAction)photoButtonPressed;
- (IBAction)hidekeyboard:(id)sender;
- (IBAction)informacion:(id)sender;


@end
