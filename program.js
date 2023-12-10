import * as G from "./game-engine.js"

G.game(
    G.put_image(200, 300),
    G.sprite_level(0, 12),
    G.sprite_pos(0, 100, 50),
    G.sprite_level(1, 10),
    G.sprite_pos(1, 150, 230)
)
