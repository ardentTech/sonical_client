module QueryParams exposing (
  QueryParam, add, extractFromUrl, formatForUrl, fromRoute, fromUri)

import Http exposing (decodeUri, encodeUri)
import Json.Decode exposing (decodeString, int, keyValuePairs)
import Regex exposing (HowMany(AtMost), find, regex)
import Tuple exposing (first, second)

import Router exposing (Route (DriverList))


type alias QueryParam = { key : String, value : Int }


add : QueryParam -> List QueryParam -> List QueryParam
add param params =
  case get param params of
    Just p -> replace param params
    Nothing -> param :: params


-- @todo this only handles numbers for now
extractFromUrl : String -> Maybe String -> Maybe Int
extractFromUrl key haystack =
  let
    matcher = (\h ->
      List.head <| List.map .match (find (AtMost 1) (regex (key ++ "=(\\d+)")) h))
  in
    case haystack of
      Just h -> case (matcher h) of
        Just v -> case (List.head <| List.reverse <| String.split "=" v) of
          Just t -> case String.toInt t of
            Ok i -> Just i
            Err _ -> Nothing
          Nothing -> Nothing
        Nothing -> Nothing
      Nothing -> Nothing


formatForUrl : List QueryParam -> String
formatForUrl queryParams =
  if (List.length queryParams > 0) then "?" ++ (join queryParams) else ""


fromRoute : Maybe Route -> List QueryParam
fromRoute route =
  case route of
    Just (DriverList q) ->
      case q of
        Just q -> fromEncodedUri q
        Nothing -> []
    Nothing -> []
    _ -> []


-- PRIVATE


formatAsKeyEqualsValue : QueryParam -> String
formatAsKeyEqualsValue qp = 
  qp.key ++ "=" ++ (toString qp.value)


fromEncodedUri : String -> List QueryParam
fromEncodedUri uri =
  case (decodeUri uri) of
    Just d -> fromUri d
    Nothing -> []


fromUri : String -> List QueryParam
fromUri uri =
  case (decodeString (keyValuePairs int) uri) of
    Ok pairs -> List.map (\p -> QueryParam (first p) (second p)) pairs
    Err _ -> []


get : QueryParam -> List QueryParam -> Maybe QueryParam
get param params =
  List.head <| List.filter (\p -> p.key == param.key) params 


join : List QueryParam -> String
join queryParams =
  String.join "&" (List.map formatAsKeyEqualsValue queryParams)


replace : QueryParam -> List QueryParam -> List QueryParam
replace param params =
  param :: List.filter (\qp -> qp.key /= param.key) params
