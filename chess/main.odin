package chess
import "core:fmt"
import "vendor:raylib"

main :: proc() {
	fmt.println("Hello World!")
	raylib.InitWindow(300, 400, "Chess")
	raylib.SetTargetFPS(60)

	for !raylib.WindowShouldClose() {
		raylib.BeginDrawing()
		raylib.ClearBackground(raylib.BLACK)
		raylib.DrawCircle(100, 100, 100, raylib.DARKBLUE)
		raylib.EndDrawing()
	}
}
