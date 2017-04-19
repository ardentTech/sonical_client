module Commands exposing (
  getDrivers, getDriversByManufacturer, getManufacturers, searchDrivers)

import Api exposing (driversUrl, manufacturersUrl)
import Decoders exposing (driversDecoder, manufacturersDecoder)
import Messages exposing (Msg (GetDriversDone, GetManufacturersDone))
import Models exposing (Model)
import Rest exposing (getList)


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
    buildManufacturerQueryParam, buildSearchQueryParam]))


buildManufacturerQueryParam : Model -> Maybe QueryParam
buildManufacturerQueryParam model =
  if model.selectedManufacturer > 0 then
    Just <| QueryParam "manufacturer" (toString <| model.selectedManufacturer)
  else
    Nothing


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


getDriversByManufacturer : Model -> Cmd Msg
getDriversByManufacturer model =
  getDrivers model (Just (driversUrl model))



getManufacturers : Model -> Cmd Msg
getManufacturers model =
  let
    endpoint = manufacturersUrl model
    queryParams = buildQueryString([QueryParam "limit" "1000"])
  in
    getList (endpoint ++ queryParams) manufacturersDecoder GetManufacturersDone


searchDrivers : Model -> String -> Cmd Msg
searchDrivers model q =
  getDrivers model (Just (driversUrl model))
