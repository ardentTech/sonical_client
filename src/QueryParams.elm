module QueryParams exposing (
  QueryParam(..), add, extractFromUrl, formatForUrl, fromRoute, fromUri)

import Http exposing (decodeUri, encodeUri)
--import Regex exposing (HowMany(AtMost), find, regex)

import Router exposing (Route (DriverList))


type QueryParam =
  FloatQueryParam String Float |
  IntQueryParam String Int |
  StringQueryParam String String


-- @todo unpack


add : QueryParam -> List QueryParam -> List QueryParam
add param params =
  if (List.member param params) then replace param params else param :: params 


replace : QueryParam -> List QueryParam -> List QueryParam
replace param params =
  let
    getKey = \qp -> case qp of
      FloatQueryParam k v -> k
      IntQueryParam k v -> k
      StringQueryParam k v -> k
    paramKey = getKey param
    mismatch = \qp -> getKey qp /= paramKey
  in
    param :: List.filter mismatch params


-- @todo
extractFromUrl : String -> Maybe String -> Maybe Int
extractFromUrl key haystack =
  Nothing
--  let
--    matcher = (\h ->
--      List.head <| List.map .match (find (AtMost 1) (regex (key ++ "=(\\d+)")) h))
--  in
--    case haystack of
--      Just h -> case (matcher h) of
--        Just v -> case (List.head <| List.reverse <| String.split "=" v) of
--          Just t -> case String.toInt t of
--            Ok i -> Just i
--            Err _ -> Nothing
--          Nothing -> Nothing
--        Nothing -> Nothing
--      Nothing -> Nothing


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


-- @todo handle leading '?'
fromUri : String -> List QueryParam
fromUri uri =
  List.map (
    \p -> String.split "=" p |> toQueryParam) <| String.split "&" uri


-- PRIVATE


formatAsKeyEqualsValue : QueryParam -> String
formatAsKeyEqualsValue qp = 
  case qp of
    FloatQueryParam key val ->
      key ++ "=" ++ (toString val)
    IntQueryParam key val ->
      key ++ "=" ++ (toString val)
    StringQueryParam key val ->
      key ++ "=" ++ val


fromEncodedUri : String -> List QueryParam
fromEncodedUri uri =
  case (decodeUri uri) of
    Just d -> fromUri d
    Nothing -> []


--get : QueryParam -> List QueryParam -> Maybe QueryParam
--get param params =
--  List.head <| List.filter (\p -> p.key == param.key) params 


join : List QueryParam -> String
join queryParams =
  String.join "&" (List.map formatAsKeyEqualsValue queryParams)


toQueryParam : List String -> QueryParam
toQueryParam kvPair =
  let
    key = Maybe.withDefault "" (List.head kvPair)
    valRaw = Maybe.withDefault "" (List.reverse kvPair |> List.head)
  in
    case String.toFloat valRaw of
      Ok f -> FloatQueryParam key f
      Err _ -> StringQueryParam key valRaw
