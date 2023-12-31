#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define AVALON_BASE (int *) 0x0000
#define SDRAM_BASE (int *) 0x04000

#define MAX_FILE_SIZE 1000000  // Ajuste conforme necessário

int main() {
    FILE *file;
    char *filename = "background.bmp";

    file = fopen(filename, "rb");
    if (file == NULL) {
        printf("Erro ao abrir o arquivo %s\n", filename);
        return 1;
    }

    fseek(file, 0, SEEK_END);
    long file_size = ftell(file);
    fseek(file, 0, SEEK_SET);

    if (file_size > MAX_FILE_SIZE) {
        printf("Tamanho do arquivo excede o limite\n");
        fclose(file);
        return 1;
    }

    uint8_t image_buffer[MAX_FILE_SIZE];

    fread(image_buffer, sizeof(uint8_t), file_size, file);
    fclose(file);

    uint32_t *sdram_ptr = (uint32_t *)SDRAM_BASE;
    memcpy(sdram_ptr, image_buffer, file_size);

    printf("Imagem transferida para a SDRAM com sucesso!\n");

    return 0;
}
