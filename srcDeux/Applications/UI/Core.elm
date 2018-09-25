module UI.Core exposing (Flags, Model, Msg(..))

import Browser
import Browser.Navigation as Nav
import UI.Page exposing (Page)
import Url exposing (Url)



-- ⛩


type alias Flags =
    {}



-- 🌳


type alias Model =
    { navKey : Nav.Key
    , page : Page
    , url : Url
    }



-- 📣


type Msg
    = -- URL
      LinkClicked Browser.UrlRequest
    | UrlChanged Url
