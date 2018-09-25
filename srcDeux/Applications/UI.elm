module UI exposing (main)

import Browser
import Browser.Navigation as Nav
import Return exposing (..)
import UI.Core exposing (Flags, Model, Msg(..))
import UI.Page as Page
import Url exposing (Url)



-- ⛩


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


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( -----------------------------------------
      -- Initial model
      -----------------------------------------
      { navKey = key
      , page = Page.fromUrl url
      , url = url
      }
      -----------------------------------------
      -- Initial command
      -----------------------------------------
    , Cmd.none
    )



-- 📣


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
            singleton
                { model
                    | page = Page.fromUrl url
                    , url = url
                }



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
