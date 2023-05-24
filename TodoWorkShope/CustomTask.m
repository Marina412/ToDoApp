//
//  CustomTask.m
//  TodoWorkShope
//
//  Created by marina on 08/04/2023.
//

#import "CustomTask.h"

@implementation CustomTask
- (void)encodeWithCoder:(NSCoder *)encoder
{
 [encoder encodeObject:[self.title lowercaseString] forKey:@"title"];
 [encoder encodeObject:self.descripition forKey:@"desc"];
 [encoder encodeInteger:self.priority forKey:@"pro"];
 [encoder encodeObject:self.date forKey:@"date"];
 [encoder encodeInteger:self.state forKey:@"state"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
 if((self = [super init])) {
 self.title = [decoder decodeObjectForKey:@"title"];
 self.descripition = [decoder decodeObjectForKey:@"desc"];
 self.priority = [decoder decodeIntegerForKey:@"pro"];
 self.date = [decoder decodeObjectForKey:@"date"];
 self.state = [decoder decodeIntegerForKey:@"state"];
 }
 return self;
}
@end

