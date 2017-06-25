module Drivers.Update exposing (update)

import Drivers.Commands exposing (..)
import Drivers.Messages exposing (..)
import Models exposing (Model)
import QueryParams exposing (QueryParam(..), add, extractFromUrl, fromUri)
import Rest exposing (httpErrorString)


update : InternalMsg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    GetDriverDone (Ok driver) ->
      ({ model | driver = Just driver }, Cmd.none )
    GetDriverDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
    GetDriversDone (Ok response) ->
      let
        nextOffset = extractFromUrl "offset" response.next
        previousOffset = case nextOffset of
          Just n -> case n of
            50 -> Just 0  -- @todo don't hardcode API limit * 2
            _ -> extractFromUrl "offset" response.previous
          Nothing ->
            extractFromUrl "offset" response.previous
      in
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
          Just n -> add (IntQueryParam "offset" n) model.queryParams
          Nothing -> model.queryParams
        newModel = { model | queryParams = queryParams }
      in
        ( newModel, getDrivers newModel )
    PrevPageClicked ->
      let
        queryParams = case model.driversPreviousOffset of
          Just n -> add (IntQueryParam "offset" n) model.queryParams
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
      let
        newModel = { model | queryParams = fromUri model.driversQuery }
      in
        ( newModel, getDrivers newModel )
    QueryBuilderUpdated val ->
      ({ model | driversQuery = val }, Cmd.none )
    SetTableState newState ->
      ({ model | tableState = newState }, Cmd.none )
