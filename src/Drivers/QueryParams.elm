module Drivers.QueryParams exposing (offsetFromUrl, unpack)

import Regex exposing (..)

import Http exposing (decodeUri)
import Json.Decode exposing (decodeString, int, keyValuePairs)
import Tuple exposing (first, second)


-- @todo add
-- @todo get
-- @todo getAll



offsetFromUrl : Maybe String -> Maybe Int
offsetFromUrl url =
  case url of
    Just u -> fromParamKey "offset" u
    Nothing -> Nothing


-- @todo is this only unpacking ints and not floats?
unpack : String -> String
unpack params =
  case (decodeUri params) of
    Just v ->
      case (decodeString (keyValuePairs int) v) of  
        Ok raw -> format raw
        Err _ -> ""
    Nothing -> ""


fromParamKey : String -> String -> Maybe Int
fromParamKey needle haystack =
  let
    matcher = (\h ->
      List.head <| List.map .match (find (AtMost 1) (regex (needle ++ "=(\\d+)")) h))
  in
    case matcher haystack of
      Just s -> case String.toInt s of
        Ok v -> Just v
        Err _ -> Nothing
      Nothing -> Nothing




-- PRIVATE


format : List (String, Int) -> String
format raw =
  "?" ++ (String.join "&" (List.map (\t -> (first t) ++ "=" ++ (toString <| second t)) raw))
