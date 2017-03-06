module TypeConverters exposing (..)


maybeNumToNum : Maybe number -> number
maybeNumToNum n =
  case n of
    Nothing -> 0
    Just m -> m


maybeNumToString : Maybe number -> String
maybeNumToString n =
  toString <| maybeNumToNum <| n


maybeStringToString : Maybe String -> String
maybeStringToString s =
  case s of
    Nothing -> ""
    Just m -> m
