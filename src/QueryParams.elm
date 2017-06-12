module QueryParams exposing (..)

import List exposing (filter, filterMap, head)


type alias QueryParam = { key : String, value : Int }


-- @todo should this just overwrite the existing value? or have a 'force' parameter with default?
add : QueryParam -> List QueryParam -> List QueryParam
add param params =
  case get param.key params of
    Just p -> replace param params
    Nothing -> param :: params


get : QueryParam -> List QueryParam -> Maybe QueryParam
get param params =
  head <| filter (\p -> p.key == param.key) params 


-- @todo is 'swap' a better name?
replace : QueryParam -> List QueryParam -> List QueryParam
replace param params =
  param :: filterMap (\qp -> qp.key != param.key) params


forUrl : List QueryParam -> String
forUrl params =
  let
    assemble = param.key ++ "=" ++ (toString param.value) ++ "&"
  in
    String.dropRight 1 <| "?" ++ String.join "" (List.map assemble params)
