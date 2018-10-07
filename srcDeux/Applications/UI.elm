module UI exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, div)
import Return2
import Return3
import Svg.Elements
import Tachyons
import Tachyons.Classes as Tachyons
import UI.Backdrop
import UI.Core exposing (Flags, Model, Msg(..))
import UI.Page as Page
import UI.Ports
import UI.Reply as Reply exposing (R3D3, Reply)
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

      -- Children
      , backdrop = UI.Backdrop.initialModel
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
        Bypass ->
            Return2.withNoCmd model

        -----------------------------------------
        -- Children
        -----------------------------------------
        BackdropMsg sub ->
            model.backdrop
                |> UI.Backdrop.update sub
                |> Return3.mapCmd BackdropMsg
                |> Return3.mapModel (\child -> { model | backdrop = child })
                |> handleReplies

        -----------------------------------------
        -- URL
        -----------------------------------------
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    url
                        |> Url.toString
                        |> Nav.pushUrl model.navKey
                        |> return model

                Browser.External href ->
                    href
                        |> Nav.load
                        |> return model

        UrlChanged url ->
            ( { model
                | page = Page.fromUrl url
                , url = url
              }
            , Cmd.none
            )



-- 📣  ~  Replies


handleReplies : R3D3 Model Msg -> ( Model, Cmd Msg )
handleReplies ( model, cmd, maybeReplies ) =
    maybeReplies
        |> Maybe.withDefault []
        |> List.map translateReply
        |> List.foldl andThenUpdate ( model, cmd )


andThenUpdate : Msg -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
andThenUpdate msg ( model, cmd ) =
    model
        |> update msg
        |> Tuple.mapSecond (\c -> Cmd.batch [ cmd, c ])


return : model -> Cmd msg -> ( model, Cmd msg )
return model msg =
    ( model, msg )


translateReply : Reply -> Msg
translateReply reply =
    case reply of
        Reply.Chill ->
            Bypass



-- 📰


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ UI.Ports.fromBrain (always Bypass)
        ]



-- 🗺


view : Model -> Browser.Document Msg
view model =
    { title = "Diffuse"
    , body =
        [ root model
        ]
    }


root : Model -> Html Msg
root model =
    div
        [ Tachyons.classes
            [ Tachyons.min_vh_100 ]
        ]
        [ Html.map BackdropMsg (UI.Backdrop.view model.backdrop)
        ]
