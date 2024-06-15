package solitaire
import "vendor:raylib"

CARD_SHEET_WIDTH : uint = 14
CARD_SHEET_HEIGHT : uint = 4

pick_a_card :: proc(texture: raylib.Texture2D, i: uint) {
// Any card
	mod := i % (CARD_SHEET_WIDTH * CARD_SHEET_HEIGHT)
	x := mod % CARD_SHEET_WIDTH
	y := mod / CARD_SHEET_WIDTH

	xdelta := cast(f32)texture.width / cast(f32)CARD_SHEET_WIDTH
	ydelta := cast(f32)texture.height / cast(f32)CARD_SHEET_HEIGHT
	src := raylib.Rectangle {
		xdelta * cast(f32)x,
		ydelta * cast(f32)y,
		xdelta,
		ydelta,
	}
	raylib.DrawTextureRec(texture, src, raylib.Vector2 {100, 100}, raylib.WHITE)
}

main :: proc() {
	raylib.InitWindow(300, 400, "Solitaire")

	img := raylib.LoadImage("sprites/cards.png")
	tex := raylib.LoadTextureFromImage(img)
	raylib.UnloadImage(img)

	raylib.SetTargetFPS(60)
	for i : uint = 0; !raylib.WindowShouldClose(); i += 1 {
		raylib.BeginDrawing()
		raylib.ClearBackground(raylib.BLACK)
		pick_a_card(tex, i / 4)
		raylib.EndDrawing()
	}
}
