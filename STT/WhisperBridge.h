#import <Foundation/Foundation.h>
#ifdef __cplusplus
extern "C" {
#endif
void *whisper_init_from_file(const char *path);
void whisper_free_ctx(void *ctx);
const char *whisper_process_short(void *ctx, const float *pcm, int numSamples);
#ifdef __cplusplus
}
#endif
