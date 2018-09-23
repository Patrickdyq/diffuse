module UI exposing (main)

import Browser
import Browser.Navigation as Nav
import Return exposing (..)
import Url exposing (Url)



-- ⛩


type alias Flags =
    {}


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- 🌳


type alias Model =
    { navKey : Nav.Key
    , url : Url
    }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( -----------------------------------------
      -- Initial model
      -----------------------------------------
      { navKey = key
      , url = url
      }
      -----------------------------------------
      -- Initial command
      -----------------------------------------
    , Cmd.none
    )



-- 📣


type Msg
    = -- URL
      LinkClicked Browser.UrlRequest
    | UrlChanged Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -----------------------------------------
        -- URL
        -----------------------------------------
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    return model (Nav.pushUrl model.navKey <| Url.toString url)

                Browser.External href ->
                    return model (Nav.load href)

        UrlChanged url ->
            singleton { model | url = url }



-- 📰


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- 🗺


view : Model -> Browser.Document Msg
view model =
    { title = "Diffuse"
    , body =
        []
    }
