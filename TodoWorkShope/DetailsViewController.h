//
//  DetailsViewController.h
//  TodoWorkShope
//
//  Created by marina on 08/04/2023.
//

#import <UIKit/UIKit.h>
#import "CustomTask.h"
#import "UserDefaultsProtocl.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController<UserDefaultsProtocol>
@property CustomTask *task;
@property NSInteger taskIndex;
@end

NS_ASSUME_NONNULL_END
