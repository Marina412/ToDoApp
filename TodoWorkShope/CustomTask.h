//
//  CustomTask.h
//  TodoWorkShope
//
//  Created by marina on 08/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface CustomTask : NSObject

@property NSString *title,*descripition;
@property NSInteger  priority;
@property NSString *date;
@property NSInteger  state;


- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end

NS_ASSUME_NONNULL_END
