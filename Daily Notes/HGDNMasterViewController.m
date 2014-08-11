//
//  HGDNMasterViewController.m
//  Daily Notes
//
//  Created by HUGE | Atish Narlawar on 8/9/14.
//  Copyright (c) 2014 HugeInc. All rights reserved.
//

#import "HGDNMasterViewController.h"
#import "HGDNDetailViewController.h"
#import "HGDNData.h"

@interface HGDNMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation HGDNMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makeObjects];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

// Need this to reload table when Detail View Disappear and Master View comes back
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

// Update the _objects reference as it needs to be taken up back from HGDNData table keys if Notes been updated during edit.
-(void)makeObjects{
    _objects = [NSMutableArray arrayWithArray:[[HGDNData getAllNotes] allKeys]];
    
    [_objects sortUsingComparator:^NSComparisonResult(NSDate *obj1, NSDate *obj2) {
        return [obj2 compare: obj1];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    // Ensure unique key for each note created.
    
    NSString *key= [[NSDate date] description];
    [HGDNData setNote:kDefaultText forKey:key];
    [HGDNData setCurrentKey:key];
    [_objects insertObject:key atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // Set up a self execute segue when new note get created.
    
    [self performSegueWithIdentifier:kDetailView sender:self];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *object = _objects[indexPath.row];
    cell.textLabel.text = [[HGDNData getAllNotes] objectForKey:object];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Need to update persistent storage once cell has been deleted.
        [HGDNData removeNoteForKey:[_objects objectAtIndex:indexPath.row]];
        [HGDNData saveNotes];
        
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:kDetailView]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // Key is String now.
        NSString *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
