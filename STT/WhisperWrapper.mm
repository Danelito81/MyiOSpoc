#import "WhisperBridge.h"
#import "whisper.h"
void *whisper_init_from_file(const char *path) {
    struct whisper_context_params cparams = whisper_context_default_params();
    struct whisper_context *ctx = whisper_init_from_file_with_params(path, cparams);
    return (void *)ctx;
}
void whisper_free_ctx(void *ctx) {
    if (!ctx) return;
    whisper_free((struct whisper_context *)ctx);
}
const char *whisper_process_short(void *ctx, const float *pcm, int numSamples) {
    static std::string out; out.clear();
    if (!ctx || !pcm || numSamples <= 0) return nullptr;
    auto *wctx = (struct whisper_context *)ctx;
    whisper_full_params params = whisper_full_default_params(WHISPER_SAMPLING_GREEDY);
    params.translate = false; params.no_context = true; params.single_segment = true;
    params.language = "sv"; params.n_threads = 4; params.audio_ctx = 0;
    if (whisper_full(wctx, params, pcm, numSamples) != 0) return nullptr;
    int n = whisper_full_n_segments(wctx);
    for (int i = 0; i < n; i++) {
        const char *seg = whisper_full_get_segment_text(wctx, i);
        if (seg) { out += seg; out += " "; }
    }
    return out.empty() ? nullptr : out.c_str();
}
