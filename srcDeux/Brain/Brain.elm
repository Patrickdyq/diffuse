module Brain exposing (main)

-- 🧠


main : Program {} () ()
main =
    Platform.worker
        { init = \flags -> ( (), Cmd.none )
        , update = \msg model -> ( (), Cmd.none )
        , subscriptions = \model -> Sub.none
        }
