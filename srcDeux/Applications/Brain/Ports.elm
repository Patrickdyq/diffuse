port module Brain.Ports exposing (incoming, outgoing)

import Alien



-- 📣


port outgoing : Alien.Event -> Cmd msg



-- 📰


port incoming : (Alien.Event -> msg) -> Sub msg
