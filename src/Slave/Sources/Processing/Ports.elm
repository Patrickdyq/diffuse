port module Sources.Processing.Ports exposing (..)

import Sources.Processing.Types exposing (..)


-- 💡


port makeTorrentTree : ContextForTree -> Cmd msg


port requestTags : ContextForTags -> Cmd msg



-- 🚽


port receiveTags : (ContextForTags -> msg) -> Sub msg


port receiveTorrentTree : (ContextForTree -> msg) -> Sub msg
