#import <Foundation/Foundation.h>
#import "WYSafeCast.h"
id WYSafeCastObject(id obj, Class classType)
{
    if ([obj isKindOfClass:classType])
    {
        return obj;
    }
    return classType ? nil : obj;
}

id WYSafeCastProtocol(id obj, Protocol* protocolType)
{
    if ([obj conformsToProtocol:protocolType])
    {
        return obj;
    }
    return protocolType ? nil : obj;
}
