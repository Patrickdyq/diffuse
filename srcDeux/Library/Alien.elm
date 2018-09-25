module Alien exposing (Event)

{-| 👽 Aliens.

This involves the incoming and outgoing data.
Or in other words, the communication between the different Elm apps/workers.

-}

import Json.Encode



-- 🌳


type alias Event =
    { tag : String, data : Json.Encode.Value, error : Maybe String }
