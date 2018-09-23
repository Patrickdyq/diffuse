module Main where

import Flow
import Protolude hiding (list)
import Renderers
import Shikensu hiding (list)
import Shikensu.Contrib
import Shikensu.Contrib.IO as Shikensu
import Shikensu.Utilities

import qualified Data.Char as Char
import qualified Data.List as List


-- | (• ◡•)| (❍ᴥ❍ʋ)


main :: IO Dictionary
main =
    do
        se <- sequences

        -- Execute flows
        -- & reduce to a single dictionary
        let dictionary = List.concatMap (flow ()) se

        -- Make a file tree
        -- and then write to disk
        write "../build" dictionary


list :: [Char] -> IO Dictionary
list pattern =
    Shikensu.listRelativeF "./srcDeux" [pattern] >>= Shikensu.read



-- Sequences


data Sequence
    = Css
    | Favicons
    | Fonts
    | Hosting
    | Html
    | Images
    | Js
    | Manifest


sequences :: IO [( Sequence, Dictionary )]
sequences = lsequence
    [ ( Css,            list "Static/Css/**/*.css"      )
    , ( Favicons,       list "Static/Favicons/**/*.*"   )
    , ( Fonts,          list "Static/Fonts/**/*.*"      )
    , ( Hosting,        list "Static/Hosting/**/*"      )
    , ( Html,           list "Static/Html/**/*.html"    )
    , ( Images,         list "Static/Images/**/*.*"     )
    , ( Js,             list "Js/**/*.js"               )
    , ( Manifest,       list "Static/manifest.json"     )
    ]



-- Flows


flow :: Dependencies -> (Sequence, Dictionary) -> Dictionary
flow _ (Html, dict) =
    dict
        |> rename "Application.html" "200.html"
        |> clone "200.html" "index.html"


flow _ (Css, dict)            = dict |> map lowerCasePath
flow _ (Favicons, dict)       = dict
flow _ (Fonts, dict)          = prefixDirname "fonts/" dict
flow _ (Hosting, dict)        = dict
flow _ (Images, dict)         = prefixDirname "images/" dict
flow _ (Js, dict)             = dict |> map lowerCasePath
flow _ (Manifest, dict)       = dict



-- Additional IO
-- Flow dependencies


type Dependencies = ()



-- Utilities


lowerCasePath :: Definition -> Definition
lowerCasePath def =
    Shikensu.forkDefinition
        ( def
            |> localPath
            |> List.map Char.toLower
        )
        def
