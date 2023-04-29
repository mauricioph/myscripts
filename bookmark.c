#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

#define BUFSIZE 1024
#define SNIPPETS_DIR ".local/share/snippets"
#define SNIPPETS_FILE ".local/share/snippets/snippets.txt"

int main(void) {
    char buffer[BUFSIZE], input[BUFSIZE], snippets_dir[1024], snippets_file[1024];
    FILE *snippets_fp;
    int dir_created = 0;
    if(!isatty(fileno(stdin))) {
        if (fgets(input, BUFSIZE, stdin) == NULL) {
            fprintf(stderr, "Input is empty, nothing to save");
            return 1;
        }
        // remove trailing newline
        input[strcspn(input, "\n")] = 0;
    }else {
        printf("Usage: echo <string> | %s \n", __FILE__);
        printf("This program is intended to be used with piped input\n");
        return 1;
    }
    // Construct the full path to the directory and file
    snprintf(snippets_dir, sizeof(snippets_dir), "%s/%s", getenv("HOME"), SNIPPETS_DIR);
    snprintf(snippets_file, sizeof(snippets_file), "%s/%s", getenv("HOME"), SNIPPETS_FILE);

    // Create directory if it doesn't exist
    if (access(snippets_dir, F_OK) == -1) {
        if (mkdir(snippets_dir, 0775) == -1) {
            perror("mkdir");
            return 1;
        }
        dir_created = 1;
    }
    // Check if the file exists, if it does not create it 
    if(access(snippets_file, F_OK) == -1) {
        snippets_fp = fopen(snippets_file, "w");
        if(!snippets_fp) {
            perror("fopen");
            if (dir_created) {
                rmdir(snippets_dir);
            }
            return 1;
        }
    } else {
        snippets_fp = fopen(snippets_file, "r+");
        if (!snippets_fp) {
            perror("fopen");
            if (dir_created) {
                rmdir(snippets_dir);
            }
            return 1;
        }
        // Check if the string already exists in the file
        while (fgets(buffer, BUFSIZE, snippets_fp)) {
            if (strcmp(buffer, input) == 0) {
                printf("Text already exists in file\n");
                fclose(snippets_fp);
                return 0;
            }
        }
    }
    // Append input to the end of the file
    fseek(snippets_fp, 0, SEEK_END);
    fputs(input, snippets_fp);
    fputs("\n", snippets_fp);
    printf("Text saved to %s\n", snippets_file);
    fclose(snippets_fp);
    return 0;
}
