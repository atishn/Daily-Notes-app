//
//  HGDNDetailViewController.h
//  Daily Notes
//
//  Created by HUGE | Atish Narlawar on 8/9/14.
//  Copyright (c) 2014 HugeInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGDNDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UITextView *tView;

@end
