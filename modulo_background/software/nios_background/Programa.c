#include <stdio.h>
#include <stdint.h>
#include <string.h>


#define AVALON_BASE (int *) 0x0000
#define SDRAM_BASE (int *) 0x08000

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


    uint8_t *image_buffer = (uint8_t *)malloc(file_size * sizeof(uint8_t));
    if (image_buffer == NULL) {
        printf("Erro ao alocar memória para a imagem\n");
        fclose(file);
        return 1;
    }


    fread(image_buffer, sizeof(uint8_t), file_size, file);
    fclose(file);


    uint32_t *sdram_ptr = (uint32_t *)SDRAM_BASE;
    memcpy(sdram_ptr, image_buffer, file_size);


    free(image_buffer);


    printf("Imagem transferida para a SDRAM com sucesso!\n");

    return 0;
}
