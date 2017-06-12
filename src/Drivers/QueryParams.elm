module Drivers.QueryParams exposing (offsetFromUrl, unpack)

import Regex exposing (..)

import Http exposing (decodeUri)
import Json.Decode exposing (decodeString, int, keyValuePairs)
import Tuple exposing (first, second)


offsetFromUrl : Maybe String -> Maybe Int
offsetFromUrl url =
  let
    matcher = (\url ->
      List.head <| List.map .match (find (AtMost 1) (regex "offset=(\\d+)") url))
  in
    case url of
      Just u -> case matcher u of
        Just s -> case String.toInt s of
          Ok v -> Just v
          Err _ -> Nothing
        Nothing -> Nothing
      Nothing -> Nothing


unpack : String -> String
unpack params =
  case (decodeUri params) of
    Just v ->
      case (decodeString (keyValuePairs int) v) of  
        Ok raw -> format raw
        Err _ -> ""
    Nothing -> ""


-- PRIVATE


format : List (String, Int) -> String
format raw =
  "?" ++ (String.join "&" (List.map (\t -> (first t) ++ "=" ++ (toString <| second t)) raw))
