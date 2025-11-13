#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <dirent.h>
#include <string.h>

typedef void (*hello_fn_t)(void);

void load_and_call(const char *path) {
    void *h = dlopen(path, RTLD_NOW | RTLD_LOCAL);
    if (!h) {
        fprintf(stderr, "dlopen(%s) failed: %s\n", path, dlerror());
        exit(1);
    }
    dlerror();
    hello_fn_t fn = (hello_fn_t) dlsym(h, "hello_world");
    char *err = dlerror();
    if (err) {
        fprintf(stderr, "dlsym(%s) failed: %s\n", path, err);
        dlclose(h);
        exit(1);
    }
    fn();
    dlclose(h);
}

int main(void) {
    printf("================ Polyglot Hello World ================\n");
    fflush(stdout);
    const char *plugin_dir = "./hello_plugins";
    DIR *dir = opendir(plugin_dir);
    if (!dir) {
        perror("opendir");
        return 1;
    }
    struct dirent *entry;
    char path[512];
    size_t prefix_len = strlen("hello_");
    while ((entry = readdir(dir)) != NULL) {
        const char *name = entry->d_name;
        size_t len = strlen(name);
        if (len > 3 && strncmp(name, "hello_", prefix_len) == 0 && strcmp(name + len - 3, ".so") == 0) {
            snprintf(path, sizeof(path), "%s/%s", plugin_dir, name);
            load_and_call(path);
        }
    }
    closedir(dir);
    putchar('\n');
    return 0;
}
