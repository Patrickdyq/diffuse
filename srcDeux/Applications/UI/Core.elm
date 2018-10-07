module UI.Core exposing (Flags, Model, Msg(..))

import Browser
import Browser.Navigation as Nav
import UI.Backdrop
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

    -- Children
    , backdrop : UI.Backdrop.Model
    }



-- 📣


type Msg
    = Bypass
      -- Children
    | BackdropMsg UI.Backdrop.Msg
      -- URL
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url
