module QueryParams exposing (unpack)

import Http exposing (decodeUri, encodeUri)
import Json.Decode exposing (decodeString, int, keyValuePairs)
import Tuple exposing (first, second)


type alias QueryParam = { key : String, value : Int }


-- why not just store a List QueryParam in the model instead of an actual URL query string??
unpack : String -> String
unpack params =
  fromEncodedUri params |> join


-- PRIVATE


formatAsKeyEqualsValue : QueryParam -> String
formatAsKeyEqualsValue qp = 
  qp.key ++ "=" ++ (toString qp.value)


join : List QueryParam -> String
join queryParams =
  String.join "&" (List.map formatAsKeyEqualsValue queryParams)


fromEncodedUri : String -> List QueryParam
fromEncodedUri uri =
  case (decodeUri uri) of
    Just d ->
      case (decodeString (keyValuePairs int) d) of
        Ok pairs -> List.map (\p -> QueryParam (first p) (second p)) pairs
        Err _ -> []  -- @todo this should do something different
    Nothing -> []  -- @todo this should do something different


-- @todo
--toEncodedUri : List QueryParam -> String
--toEncodedUri queryParams =
--  String.join "&" (List.map formatAsKeyEqualsValue queryParams)


-- PRIVATE


--formatForUrl : List (String, Int) -> String
--formatForUrl raw =
--  "?" ++ (String.join "&" (List.map (\t -> (first t) ++ "=" ++ (toString <| second t)) raw))

--import List exposing (filter, filterMap, head)
--
--
--type alias QueryParam = { key : String, value : Int }
--
--
---- @todo should this just overwrite the existing value? or have a 'force' parameter with default?
--add : QueryParam -> List QueryParam -> List QueryParam
--add param params =
--  case get param.key params of
--    Just p -> replace param params
--    Nothing -> param :: params
--
--
--get : QueryParam -> List QueryParam -> Maybe QueryParam
--get param params =
--  head <| filter (\p -> p.key == param.key) params 
--
--
---- @todo is 'swap' a better name?
--replace : QueryParam -> List QueryParam -> List QueryParam
--replace param params =
--  param :: filterMap (\qp -> qp.key != param.key) params
--
--
--forUrl : List QueryParam -> String
--forUrl params =
--  let
--    assemble = param.key ++ "=" ++ (toString param.value) ++ "&"
--  in
--    String.dropRight 1 <| "?" ++ String.join "" (List.map assemble params)
