//
//  UserDefaultsProtocl.h
//  TodoWorkShope
//
//  Created by marina on 08/04/2023.
//

@protocol UserDefaultsProtocol <NSObject>

@optional
-(NSMutableArray *) getArrayOfCustomObjectsToUserDefaults;
-(void)saveArrayOfCustomObjectsToUserDefaults;
-(void)saveDeletedArrayOfCustomObjectsToUserDefaults;
-(void)saveUpdatedArrayOfCustomObjectsToUserDefaults;
@end
