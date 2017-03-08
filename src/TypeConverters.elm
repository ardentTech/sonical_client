module TypeConverters exposing (..)


maybeFloatToFloat : Maybe Float -> Float
maybeFloatToFloat f =
  case f of
    Nothing -> 0.0
    Just g -> g


maybeIntToInt : Maybe Int -> Int
maybeIntToInt i =
  case i of
    Nothing -> 0
    Just j -> j


maybeNumToNum : Maybe number -> number
maybeNumToNum n =
  case n of
    Nothing -> 0
    Just m -> m


maybeNumToStr : Maybe number -> String
maybeNumToStr n =
  toString <| maybeNumToNum <| n


maybeStrToStr : Maybe String -> String
maybeStrToStr s =
  case s of
    Nothing -> ""
    Just st -> st
