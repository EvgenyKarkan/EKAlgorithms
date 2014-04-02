
#import <Kiwi/Kiwi.h>

FOUNDATION_EXPORT uint64_t dispatch_benchmark(size_t count, void (^block)(void));
static inline void Benchmark(size_t n, void(^block)(void)) {
    float time = (float)dispatch_benchmark(n, block);

    NSLog(@"The block have been run %zu times. Average time is %f milliseconds",  n, (time / 1000000));
}



