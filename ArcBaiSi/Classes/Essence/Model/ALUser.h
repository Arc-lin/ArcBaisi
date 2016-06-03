//
//  ALUser.h
//  ArcBaiSi
//
//  Created by Arclin on 16/5/25.
//  Copyright © 2016年 sziit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALUser : NSObject

/** 用户名 */
@property (nonatomic,copy) NSString *username;

/** 性别 */
@property (nonatomic,copy) NSString *sex;

/** 头像 */
@property (nonatomic,copy) NSString *profile_image;

@end
