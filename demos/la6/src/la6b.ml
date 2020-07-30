open UniverseJs
open Color
open Image
open World
open TransformToInt

type world_t = {
  usagi : int * int;
  kame : int * int;
}
let width = 560
let height = 560
let length = 100
let start = (210, 70)
let goal = (350, 490)
let initial_world = {usagi = start; kame = start}
let usagi_right = read_image "img/usagi_right.png" 100 100
let usagi_left = read_image "img/usagi_left.png" 100 100
let usagi_break = read_image "img/usagi_break.png" 100 100
let kame_right = read_image "img/kame_right.png" 100 100
let kame_left = read_image "img/kame_left.png" 100 100
let goalzone = read_image "img/goal.png" 210 70
let back = read_image "img/back.png" width height
let direction (x, y) =
  y = height / 2
let break (ux, uy) (kx, ky) =
  uy = 280
let draw {usagi = usagi_v; kame = kame_v} =
  place_image (if direction kame_v then kame_left
  else kame_right) kame_v (place_image (if break usagi_v kame_v then usagi_break
  else if direction usagi_v then usagi_left
  else usagi_right) usagi_v (place_image (text "(490, 280)" 25 Color.black) (490, 280) (place_image goalzone (350, 525) (place_image back (280, 280) (empty_scene width height)))))
let move_u = 30
let move_k = 10
let move (x, y) v =
  if y < 280 then (x + v, (x + v) - 140)
  else if x > 140 && y = 280 then (x - v, y)
  else (x + v, x + v + 140)
let move_break (ux, uy) (kx, ky) move_u =
  if ? then (490, 280)
  else move (ux, uy) move_u
let on_tick {usagi = usagi4_v; kame = kame4_v} =
  {usagi = move_break usagi4_v kame4_v move_u; kame = move kame4_v move_k}
;; big_bang initial_world
  ~width:width
  ~height:height
  ~to_draw:draw
  ~on_tick:on_tick
  ~rate:100
