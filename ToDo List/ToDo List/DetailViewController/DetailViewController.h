//
//  ViewController.h
//  ToDo List
//
//  Created by Алексей Шевченко on 02.03.2023.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSDate * eventDate;
@property (nonatomic, strong) NSString * eventInfo;
@property (nonatomic, assign) BOOL isDetail;

@end

