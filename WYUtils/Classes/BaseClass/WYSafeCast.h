//
//  WYSafeCast.h
//  WYUtils
//
//  Created by wyan on 2023/4/21.
//

#ifdef __cplusplus
extern "C" {
#endif

id WYSafeCastObject(id obj, Class classType);
id WYSafeCastProtocol(id obj, Protocol *protocolType);

#ifdef __cplusplus
}
#endif

/**
 安全无比的类型转换
 
 @b Tag 类型转换 安全
 */


#ifndef WYSAFE_CAST
#define WYSAFE_CAST(obj, asClass)  WYSafeCastObject(obj, [asClass class])
#endif

#ifndef SAFE_CAST_PROTOCOL
#define SAFE_CAST_PROTOCOL(obj, asClass)  WYSafeCastProtocol(obj, @protocol(asClass))
#endif
