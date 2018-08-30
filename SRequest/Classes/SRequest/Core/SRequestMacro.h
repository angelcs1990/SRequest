//
//  SRequestMacro.h
//  SRequest
//
//  Created by chens on 2018/7/30.
//  Copyright © 2018年 chens. All rights reserved.
//

#ifndef SRequestMacro_h
#define SRequestMacro_h


#if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
# define SFinal_Class __attribute__((objc_subclassing_restricted))
#else
# define SFinal_Class
#endif



#define S_SYNTHESIZE(_name) @synthesize _name = _##_name

#endif /* SRequestMacro_h */
