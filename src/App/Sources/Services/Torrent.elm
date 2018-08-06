module Sources.Services.Torrent exposing (..)

{-| Torrent Service.

For those all torrents out there.

-}

import Date exposing (Date)
import Dict
import Dict.Ext as Dict
import Http
import Json.Encode
import Sources.Pick
import Sources.Processing.Ports
import Sources.Processing.Types exposing (..)
import Sources.Services.Utils exposing (noPrep)
import Sources.Types exposing (SourceData)


-- Properties
-- 📟


defaults =
    { name = "Music from Torrent"
    }


{-| The list of properties we need from the user.

Tuple: (property, label, placeholder, isPassword)
Will be used for the forms.

-}
properties : List ( String, String, String, Bool )
properties =
    [ ( "identifier", "Torrent URL / Magnet URI", "https://some.server/music.torrent", False )
    , ( "name", "Label", defaults.name, False )
    ]


{-| Initial data set.
-}
initialData : SourceData
initialData =
    Dict.fromList
        [ ( "identifier", "" )
        , ( "name", defaults.name )
        ]



-- Preparation


prepare : String -> SourceData -> Marker -> Maybe (Http.Request String)
prepare _ _ _ =
    Nothing



-- Tree


{-| Create a directory tree.

List all the tracks in the bucket.
Or a specific directory in the bucket.

-}
makeTree : Context -> Date -> (Result Http.Error String -> Msg) -> Cmd Msg
makeTree context _ _ =
    let
        sourceData =
            context.source.data
                |> Dict.toList
                |> List.map (Tuple.mapSecond Json.Encode.string)
                |> Json.Encode.object
                |> Json.Encode.encode 0
    in
        Sources.Processing.Ports.makeTorrentTree
            { filePaths = []
            , sourceId = context.source.id
            , sourceData = sourceData
            }


{-| Re-export parser functions.
-}
parsePreparationResponse : String -> SourceData -> Marker -> PrepationAnswer Marker
parsePreparationResponse =
    noPrep


parseTreeResponse : String -> Marker -> TreeAnswer Marker
parseTreeResponse response _ =
    { filePaths = []
    , marker = TheEnd
    }


parseErrorResponse : String -> String
parseErrorResponse =
    identity



-- Post


{-| Post process the tree results.

!!! Make sure we only use music files that we can use.

-}
postProcessTree : List String -> List String
postProcessTree =
    Sources.Pick.selectMusicFiles



-- Track URL


{-| Create a public url for a file.

We need this to play the track.

-}
makeTrackUrl : Date -> SourceData -> HttpMethod -> String -> String
makeTrackUrl currentDate srcData method pathToFile =
    "torrent://" ++ Dict.fetch "identifier" "" srcData ++ "@" ++ pathToFile
