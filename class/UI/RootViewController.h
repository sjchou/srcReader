//
//  RootViewController.h
//  srcReader
//
//  Created by victor chou on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITableView *tableViewList;
    NSMutableArray *arrayText;
    
    NSString *path;
    NSString *atricleTitle;
}
@property(nonatomic,retain)NSString *path;
@property(nonatomic,retain)NSString *atricleTitle;
-(id)initWithPath:(NSString *)_path title:(NSString *)_title1;

@end
