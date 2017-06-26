module QueryParams exposing (
  QueryParam(..), add, valueForKey, toUrl, fromRoute, fromUrl)

import Http exposing (decodeUri, encodeUri)
--import Regex exposing (HowMany(AtMost), find, regex)

import Router exposing (Route (DriverList))


type QueryParam =
  FloatType { key : String, value : Float } |
  IntType { key : String, value : Int } |
  StringType { key : String, value : String }


add : QueryParam -> List QueryParam -> List QueryParam
add param params =
  if (List.member param params) then replace param params else param :: params 


fromRoute : Maybe Route -> List QueryParam
fromRoute route =
  case route of
    Just (DriverList q) ->
      case q of
        Just q -> fromEncodedUri q
        Nothing -> []
    Nothing -> []
    _ -> []


fromUrl : String -> List QueryParam
fromUrl uri =
  List.map (
    \p -> String.split "=" p |> toQueryParam) <| String.split "&" uri


valueForKey : String -> Maybe String -> Maybe Int
valueForKey key haystack =
  Nothing
----  let
----    matcher = (\h ->
----      List.head <| List.map .match (find (AtMost 1) (regex (key ++ "=(\\d+)")) h))
----  in
----    case haystack of
----      Just h -> case (matcher h) of
----        Just v -> case (List.head <| List.reverse <| String.split "=" v) of
----          Just t -> case String.toInt t of
----            Ok i -> Just i
----            Err _ -> Nothing
----          Nothing -> Nothing
----        Nothing -> Nothing
----      Nothing -> Nothing


-- PRIVATE


toUrl : List QueryParam -> String
toUrl queryParams =
  if (List.length queryParams > 0) then "?" ++ (join queryParams) else ""


formatAsKeyEqualsValue : QueryParam -> String
formatAsKeyEqualsValue qp = 
  case qp of
    FloatType { key, value } ->
      key ++ "=" ++ (toString value)
    IntType { key, value } ->
      key ++ "=" ++ (toString value)
    StringType { key, value } ->
      key ++ "=" ++ value


fromEncodedUri : String -> List QueryParam
fromEncodedUri uri =
  case (decodeUri uri) of
    Just d -> fromUrl d
    Nothing -> []


join : List QueryParam -> String
join queryParams =
  String.join "&" (List.map formatAsKeyEqualsValue queryParams)


replace : QueryParam -> List QueryParam -> List QueryParam
replace param params =
  let
    getKey = \qp -> case qp of
      FloatType { key, value } -> key
      IntType { key, value } -> key
      StringType { key, value } -> key
    paramKey = getKey param
    mismatch = \qp -> qp.key /= getKey param
  in
--    param :: List.filter mismatch params
    param :: []


toQueryParam : List String -> QueryParam
toQueryParam kvPair =
  let
    keyRaw = Maybe.withDefault "" (List.head kvPair)
    valRaw = Maybe.withDefault "" (List.reverse kvPair |> List.head)
  in
    case String.toFloat valRaw of
      Ok f -> FloatType { key = keyRaw, value = f }
      Err _ -> StringType { key = keyRaw, value = valRaw }
