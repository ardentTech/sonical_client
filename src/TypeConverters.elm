module TypeConverters exposing (maybeNumToNum, maybeNumToString)


maybeNumToNum : Maybe number -> number
maybeNumToNum n =
  case n of
    Nothing -> 0
    Just m -> m


maybeNumToString : Maybe number -> String
maybeNumToString n =
  toString <| maybeNumToNum <| n
