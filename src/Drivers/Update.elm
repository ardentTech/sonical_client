module Drivers.Update exposing (update)

import Drivers.Commands exposing (..)
import Drivers.Messages exposing (..)
import Drivers.QueryParams exposing (offsetFromUrl)
import Models exposing (Model)
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
        nextOffset = offsetFromUrl response.next
        previousOffset = offsetFromUrl response.previous
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
        driversQuery = offsetToDriversQuery model.driversNextOffset model.driversQuery
      in
        ({ model | driversQuery = driversQuery }, Cmd.none )
    PrevPageClicked ->
      let
        driversQuery = offsetToDriversQuery model.driversPreviousOffset model.driversQuery
      in
        ({ model | driversQuery = driversQuery }, Cmd.none )
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


-- PRIVATE


offsetToDriversQuery : Maybe Int -> String -> String
offsetToDriversQuery offset query =
  case offset of
    Just o ->
      case offsetFromUrl <| Just query of
        Just i -> "OFFSET IN QUERY, SO REPLACE"
        Nothing -> "OFFSET NOT IN QUERY, SO ADD"
    Nothing -> query
