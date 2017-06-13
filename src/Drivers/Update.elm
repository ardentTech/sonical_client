module Drivers.Update exposing (update)

import Regex exposing (..)

import Drivers.Commands exposing (..)
import Drivers.Messages exposing (..)
import Models exposing (Model)
import QueryParams exposing (QueryParam, add)
import Rest exposing (httpErrorString)


extractOffset : Maybe String -> Maybe Int
extractOffset haystack =
  let
    matcher = (\h ->
      List.head <| List.map .match (find (AtMost 1) (regex ("offset=(\\d+)")) h))
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


update : InternalMsg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    GetDriverDone (Ok driver) ->
      ({ model | driver = Just driver }, Cmd.none )
    GetDriverDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
    GetDriversDone (Ok response) ->
      let
        nextOffset = extractOffset response.next
        previousOffset = case nextOffset of
          Just n -> case n of
            -- @todo don't hardcode API limit * 2
            50 -> Just 0
            _ -> extractOffset response.previous
          Nothing ->
            extractOffset response.previous
      in
        Debug.log (toString previousOffset)
        ({ model |
          drivers = response.results,
          driversCount = response.count,
          driversNextOffset = nextOffset,
          driversPreviousOffset = previousOffset
        }, Cmd.none )
    GetDriversDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
    NextPageClicked ->
      let
        queryParams = case model.driversNextOffset of
          Just n -> add (QueryParam "offset" n) model.queryParams
          Nothing -> model.queryParams
        newModel = { model | queryParams = queryParams }
      in
        ( newModel, getDrivers newModel )
    PrevPageClicked ->
      let
        queryParams = case model.driversPreviousOffset of
          Just n -> add (QueryParam "offset" n) model.queryParams
          Nothing -> model.queryParams
        newModel = { model | queryParams = queryParams }
      in
        ( newModel, getDrivers newModel )
    QueryBuilderCleared ->
      ({ model | driversQuery = "" }, Cmd.none )
    QueryBuilderHelpClicked ->
      let
        showHelp = not model.driversQueryBuilderHelp
      in
        ({ model | driversQueryBuilderHelp = showHelp }, Cmd.none )
    QueryBuilderSubmitted ->
      ( model, queryDrivers model )
    QueryBuilderUpdated val ->
      ({ model | driversQuery = val }, Cmd.none )
    SetTableState newState ->
      ({ model | tableState = newState }, Cmd.none )
