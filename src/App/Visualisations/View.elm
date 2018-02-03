module Visualisations.View exposing (entry)

import Types as TopLevel exposing (Msg(..))
import Window


-- Elements

import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Types exposing (..)
import Variables exposing (maxInsulationWidth, scaled)


-- Styles

import Styles exposing (Styles(..))


-- 🍯


entry : Window.Size -> Node
entry windowSize =
    let
        colWidth =
            (toFloat windowSize.width - maxInsulationWidth) / 2
    in
        row
            Zed
            [ inlineStyle containerStyles
            ]
            [ el
                Zed
                [ id "leftPeakMeter"
                , width (px colWidth)
                ]
                (boxes)
            , el
                Zed
                [ width fill ]
                empty
            , el
                Zed
                [ id "rightPeakMeter"
                , width (px colWidth)
                ]
                (boxes)
            ]


containerStyles : List ( String, String )
containerStyles =
    [ ( "bottom", "0" )
    , ( "left", "0" )
    , ( "position", "fixed" )
    , ( "right", "0" )
    , ( "top", "0" )
    , ( "z-index", "-9" )
    ]



-- ⚗️


peakHeight : Float
peakHeight =
    130


peakWidth : Float
peakWidth =
    28



--


boxes : Node
boxes =
    [ box "0", box "1" ]
        |> row Zed [ height (px peakHeight), width (px peakWidth) ]
        |> el Zed [ center, verticalCenter, inlineStyle [ ( "transform", "rotate(180deg)" ) ] ]


box : String -> Node
box x =
    el
        Zed
        [ height
            (px
                (if x == "0" then
                    peakHeight
                 else
                    0
                )
            )
        , class
            (if x == "0" then
                ""
             else
                "value"
            )
        , inlineStyle
            [ ( "background-image", "url('/images/Visualiations/Peak%20Meter/" ++ x ++ ".svg')" )
            , ( "left", "0" )
            , ( "position", "absolute" )
            , ( "right", "0" )
            , ( "top", "0" )
            ]
        , width (px peakWidth)
        ]
        empty
