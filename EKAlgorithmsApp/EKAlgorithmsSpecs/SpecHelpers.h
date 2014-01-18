
FOUNDATION_EXPORT uint64_t dispatch_benchmark(size_t count, void (^block)(void));
static inline void benchmark(size_t n, void(^block)(void)) {
    float time = (float)dispatch_benchmark(n, block);

    NSLog(@"The block have been run %zu times. It took %f milliseconds",  n, (time / 1000000));
}
