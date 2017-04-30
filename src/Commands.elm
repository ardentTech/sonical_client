module Commands exposing (getDrivers, queryDrivers)

import Api exposing (driversUrl)
import Decoders exposing (driversDecoder, manufacturersDecoder)
import Messages exposing (Msg (GetDriversDone))
import Models exposing (Model)
import Rest exposing (getList)


-- @todo convert manufacturer name to id
-- @todo validate input?
-- @todo clean this file up


type alias QueryParam = { key : String, value : String }


buildQueryString : List QueryParam -> String
buildQueryString params =
  let
    assemble = \qp -> qp.key ++ "=" ++ qp.value ++ "&"
  in
    if not (List.isEmpty params) then
      String.dropRight 1 ("?" ++ String.concat (List.map assemble params))
    else
      ""


buildDriverQueryString : Model -> String
buildDriverQueryString model =
  buildQueryString (List.filterMap identity (List.map (\f -> f model) [
    buildSearchQueryParam]))


buildSearchQueryParam : Model -> Maybe QueryParam
buildSearchQueryParam model =
  if (String.length model.driversQuery) > 0 then
    Just <| QueryParam "search" model.driversQuery
  else
    Nothing


getDrivers : Model -> Maybe String -> Cmd Msg
getDrivers model url =
  let
    endpoint =
      case url of
        Nothing -> driversUrl model
        Just s -> s
    queryParams = buildDriverQueryString model
  in
    getList (endpoint ++ queryParams) driversDecoder GetDriversDone


queryDrivers : Model -> Cmd Msg
queryDrivers model =
  let
    endpoint = driversUrl model
  in
    getList (endpoint ++ model.queryBuilderVal) driversDecoder GetDriversDone
