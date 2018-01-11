//
//  InfoViewController.h
//  Card Box
//
//  Created by Koldo Ruiz on 22/05/13.
//
//

#import <UIKit/UIKit.h>


@interface InfoViewController : UIViewController  {
  
        UIView *contentView;
    }





@property (nonatomic, retain) IBOutlet UIView *contentView;

@property (nonatomic, retain) IBOutlet UILabel *text1;
@property (nonatomic, retain) IBOutlet UILabel *text2;
@property (nonatomic, retain) IBOutlet UILabel *text3;

@end