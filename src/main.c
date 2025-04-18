#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void print_usage(const char *prog_name) {
    fprintf(stderr, "Usage: %s <input_csv> <output_pattern> <chunk_size>\n", prog_name);
    fprintf(stderr, "  <input_csv>: Path to the input CSV file.\n");
    fprintf(stderr, "  <output_pattern>: Pattern for output filenames (e.g., 'output_part').\n");
    fprintf(stderr, "                   Filenames will be '<output_pattern>-<number>.csv'.\n");
    fprintf(stderr, "  <chunk_size>: Number of data rows per output file (excluding header).\n");
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        print_usage(argv[0]);
        return 1;
    }

    const char *input_filename = argv[1];
    const char *output_pattern = argv[2];
    long long chunk_size = atoll(argv[3]);

    if (chunk_size <= 0) {
        fprintf(stderr, "Error: Chunk size must be a positive integer.\n");
        print_usage(argv[0]);
        return 1;
    }

    FILE *input_file = fopen(input_filename, "r");
    if (!input_file) {
        perror("Error opening input file");
        return 1;
    }

    char *header = NULL;
    size_t header_len = 0;
    ssize_t header_read;

    header_read = getline(&header, &header_len, input_file);
    if (header_read == -1) {
        fprintf(stderr, "Error reading header from input file or file is empty.\n");
        free(header);
        fclose(input_file);
        return 1;
    }

    header[strcspn(header, "\r\n")] = 0;

    int file_counter = 1;
    long long line_counter = 0;
    char *line = NULL;
    size_t line_len = 0;
    ssize_t line_read;
    FILE *output_file = NULL;

    while ((line_read = getline(&line, &line_len, input_file)) != -1) {
        if (output_file == NULL) {
            char output_filename[FILENAME_MAX];
            snprintf(output_filename, sizeof(output_filename), "%s-%d.csv", output_pattern, file_counter++);

            output_file = fopen(output_filename, "w");
            if (!output_file) {
                perror("Error creating output file");
                free(header);
                free(line);
                fclose(input_file);
                return 1; 
            }

            fprintf(output_file, "%s\n", header);
            line_counter = 0;
        }

        fprintf(output_file, "%s", line);
        line_counter++;

        // Check if chunk size reached
        if (line_counter >= chunk_size) {
             if (output_file) {
                fclose(output_file);
                output_file = NULL;
             }
        }
    }

    free(header);
    free(line);

    if (output_file) {
        fclose(output_file);
    }

    fclose(input_file);

    if (ferror(input_file)) {
        perror("Error reading input file");
        return 1;
    }

    printf("Finished splitting file '%s'.\n", input_filename);

    return 0;
} 