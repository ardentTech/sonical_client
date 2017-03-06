module TypeConverters exposing (..)


maybeNumToNum : Maybe number -> number
maybeNumToNum n =
  case n of
    Nothing -> 0
    Just m -> m


maybeNumToStr : Maybe number -> String
maybeNumToStr n =
  toString <| maybeNumToNum <| n
