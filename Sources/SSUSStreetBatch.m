#import "SSUSStreetBatch.h"

int const kSSStreetMaxBatchSize = 100;

@implementation SSUSStreetBatch

- (instancetype)init {
    if (self = [super init]) {
        _namedLookups = [[NSMutableDictionary alloc] init];
        _allLookups = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)add:(SSUSStreetLookup*)newAddress error:(NSError**)error {
    if (self.allLookups.count >= kSSStreetMaxBatchSize) {
        NSString *description = [NSString stringWithFormat:@"Batch size cannot exceed %i", kSSStreetMaxBatchSize];
        NSDictionary *details = @{NSLocalizedDescriptionKey: description};
        *error = [NSError errorWithDomain:SSErrorDomain code:BatchFullError userInfo:details];
        return NO;
    }
    
    [self.allLookups addObject:newAddress];
    
    NSString *key = newAddress.inputId;
    if (key == nil)
        return YES;
    
    [self.namedLookups setObject:newAddress forKey:key];
    
    return YES;
}

- (void)removeAllObjects {
    [self.allLookups removeAllObjects];
    [self.namedLookups removeAllObjects];
}

- (int)count {
    return (int)[self.allLookups count];
}

- (SSUSStreetLookup*)getLookupById:(NSString*)inputId {
    return [self.namedLookups objectForKey:inputId];
}

- (SSUSStreetLookup*)getLookupAtIndex:(int)inputIndex {
    return [self.allLookups objectAtIndex:inputIndex];
}

@end