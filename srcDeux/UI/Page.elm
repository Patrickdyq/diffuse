module Page exposing (Page(..), fromUrl)

import Url exposing (Url)
import Url.Parser exposing (..)



-- 🌳


type Page
    = Index
    | NotFound



-- ⚡️


fromUrl : Url -> Page
fromUrl url =
    url
        |> parse route
        |> Maybe.withDefault NotFound



-- ⚗️


route : Parser (Page -> a) a
route =
    oneOf
        [ map Index top
        ]
