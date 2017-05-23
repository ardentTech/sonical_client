module Drivers.QueryParams exposing (unpack)

import Http exposing (decodeUri)
import Json.Decode exposing (decodeString, int, keyValuePairs)
import Tuple exposing (first, second)


unpack : String -> String
unpack params =
  case (decodeUri params) of
    Just v ->
      case (decodeString (keyValuePairs int) v) of  
        Ok raw -> format raw
        _ -> ""
    Nothing -> ""


-- PRIVATE


format : List (String, Int) -> String
format raw =
  "?" ++ (String.join "&" (List.map (\t -> (first t) ++ "=" ++ (toString <| second t)) raw))
