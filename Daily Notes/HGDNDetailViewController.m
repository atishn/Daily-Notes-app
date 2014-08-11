//
//  HGDNDetailViewController.m
//  Daily Notes
//
//  Created by HUGE | Atish Narlawar on 8/9/14.
//  Copyright (c) 2014 HugeInc. All rights reserved.
//

#import "HGDNDetailViewController.h"
#import "HGDNData.h"

@interface HGDNDetailViewController ()
- (void)configureView;
@end

@implementation HGDNDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [HGDNData setCurrentKey:_detailItem];
        // Update the view.
        [self configureView];
    }
}

// While View disapper, if nothing entered its better to clean the key from the table.
-(void) viewWillDisappear:(BOOL)animated{
    if(![self.tView.text isEqualToString:@""]){
        [HGDNData setNoteForCurrentKey:self.tView.text];
    }else{
        [HGDNData removeNoteForKey:[HGDNData getCurrentKey]];
    }
    [HGDNData saveNotes];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    NSString *currentNote = [[HGDNData getAllNotes] objectForKey:[HGDNData getCurrentKey]];
    if(![currentNote isEqualToString:kDefaultText]){
        self.tView.text = currentNote;
    }else{
        self.tView.text = @"";
    }
    [self.tView becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
