//
//  ImageZoomViewController.h
//  Card Box
//
//  Created by Koldo Ruiz on 22/05/13.
//
//

#import <UIKit/UIKit.h>


@class Recipes;

@interface ImageZoomViewController : UIViewController<UIScrollViewDelegate> {
   
    
    UIImage *tarjeta1;
    UIImage *tarjeta2;
    
    IBOutlet UIImageView * demoImageView;    
    
    Recipes *recipes;
    
    
 
    UIView *contentView;
}

@property(nonatomic, assign) IBOutlet UIScrollView *scrollView;


@property (nonatomic, retain) IBOutlet UIImageView * demoImageView;


@property(nonatomic, strong) UITapGestureRecognizer *singleTap;
@property(nonatomic, strong) UITapGestureRecognizer *doubleTap;
@property(nonatomic, strong) UITapGestureRecognizer *twoFingerTap;

@property (nonatomic, retain) Recipes *recipes;


@property (nonatomic, retain) IBOutlet UIView *contentView;



@end

