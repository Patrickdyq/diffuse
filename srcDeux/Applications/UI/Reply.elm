module UI.Reply exposing (R3D3, Reply(..), none)

-- 🌳


type Reply
    = Chill


type alias R3D3 model msg =
    ( model, Cmd msg, Maybe (List Reply) )



-- ⛩


none : Reply
none =
    Chill
