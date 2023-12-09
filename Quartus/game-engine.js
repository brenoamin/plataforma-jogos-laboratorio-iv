import processCode from "lab4-compiler/core.js"
import { writeFileSync } from 'fs';


export function put_image(x, y) {
    return `lw r2, ${x} (r0)\nlw r3, ${y} (r0)`;
}

export function sprite_level(level, sprite_id) {
    return `lw r4, ${level} (r0)\nlw r5, ${sprite_id} (r0)`;
}

export function sprite_pos(level, x, y) {
    return `lw r6, ${level} (r0)\nlw r7, ${x} (r0)\nlw r8, ${y} (r0)`;
}

export function loop(...instructions) {
    
}

export function game(...instructions) {
    let asm = instructions
        .map(instruction => instruction)
        .join('\n')

    let bin = processCode(asm)

    writeFileSync('./program.bin', bin)
}
