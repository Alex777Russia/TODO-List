//
//  MainTableTableViewController.m
//  ToDo List
//
//  Created by Алексей Шевченко on 02.03.2023.
//

#import "MainTableTableViewController.h"
#import "DetailViewController.h"

@interface MainTableTableViewController ()

@property (nonatomic, strong) NSMutableArray * arrayEvents;

@end

@implementation MainTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    self.arrayEvents = [[NSMutableArray alloc] initWithArray:array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableViewWhenEvent)
                                                 name:@"NewEvent"
                                               object:nil];
    
    [self.tableView
     reloadSections:[NSIndexSet indexSetWithIndex:0]
     withRowAnimation:UITableViewRowAnimationFade];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void) reloadTableViewWhenEvent {
    [self.arrayEvents removeAllObjects];
    
    NSArray * array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    self.arrayEvents = [[NSMutableArray alloc] initWithArray:array];
    
    [self.tableView
     reloadSections:[NSIndexSet indexSetWithIndex:0]
     withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayEvents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * indentifier = @"Cell";
    
    UITableViewCell * cell = [tableView
                              dequeueReusableCellWithIdentifier:indentifier
                              forIndexPath:indexPath];
    
    UILocalNotification * notification = [self.arrayEvents
                                          objectAtIndex:indexPath.row];
    
    NSDictionary * dict = notification.userInfo;
    
    cell.textLabel.text = [dict objectForKey:@"eventInfo"];
    cell.detailTextLabel.text = [dict objectForKey:@"eventDate"];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UILocalNotification * notification = [self.arrayEvents
                                          objectAtIndex:indexPath.row];
    
    NSDictionary * dict = notification.userInfo;
    
    DetailViewController * detailView = [self.storyboard
                                         instantiateViewControllerWithIdentifier:@"detailView"];
    
    detailView.eventInfo = [dict objectForKey:@"eventInfo"];
    
    detailView.eventInfo = [dict objectForKey:@"eventInfo"];
    detailView.eventDate = notification.fireDate;
    detailView.isDetail = YES;
    
    [self.navigationController
     pushViewController:detailView
     animated:YES];
}

// MARK: -- methods for changed cell on tableView

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UILocalNotification * notification = [self.arrayEvents objectAtIndex:indexPath.row];
        
        [[UIApplication sharedApplication] cancelLocalNotification: notification];
        
        [self.arrayEvents removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
