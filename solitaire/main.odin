package solitaire
import "core:fmt"
import "vendor:raylib"
import "core:math/rand"

// Suits correspond to the spritesheet
Suit :: enum{
	Spade,
	Diamond,
	Heart,
	Club,
}

Card :: struct {
	number: int,
	suit: Suit,
}

CARD_SHEET_WIDTH : uint : 14
CARD_SHEET_HEIGHT : uint : 4
BG_COLOR :: raylib.Color { 0, 255, 0, 255 }

// Corresponds to the sprite sheet
DOWN_CARD :: Card { 14, Suit.Diamond }
NUMBER_MAX :: 13
SUIT_MAX :: 4

card_from_u8 :: proc(n: u8) -> Card {
	return Card { int(n % NUMBER_MAX) + 1, Suit(n / NUMBER_MAX) }
}

draw_card :: proc(texture: raylib.Texture2D, card: Card, dst: raylib.Vector2) {
	x := uint(card.number - 1) % CARD_SHEET_WIDTH
	y := uint(card.suit)

	xdelta := cast(f32)texture.width / cast(f32)CARD_SHEET_WIDTH
	ydelta := cast(f32)texture.height / cast(f32)CARD_SHEET_HEIGHT
	src := raylib.Rectangle {
		xdelta * cast(f32)x,
		ydelta * cast(f32)y,
		xdelta,
		ydelta,
	}
	raylib.DrawTextureRec(texture, src, dst, raylib.WHITE)
}

main :: proc() {
	raylib.InitWindow(800, 600, "Solitaire")

	img := raylib.LoadImage("sprites/cards.png")
	tex := raylib.LoadTextureFromImage(img)
	raylib.UnloadImage(img)

	// Initialize card deck and then shuffle it it
	deck: [NUMBER_MAX * SUIT_MAX]u8
	for i : u8 = 0; i < len(deck); i += 1 {
		deck[i] = i
	}
	rand.shuffle(deck[:])
		for i := 0; i < 5; i += 1 {
			fmt.println(deck[i])
		}

	raylib.SetTargetFPS(60)
	for i : uint = 0; !raylib.WindowShouldClose(); i += 1 {
		raylib.BeginDrawing()
		raylib.ClearBackground(BG_COLOR)
		draw_card(tex, DOWN_CARD, raylib.Vector2 {40, 30})
		for j := 0; j < 5; j += 1 {
			draw_card(tex, card_from_u8(deck[j]), raylib.Vector2 {f32(50 + 150 * j), 400})
		}
		raylib.EndDrawing()
	}
}
