module Drivers.Update exposing (update)

import Navigation exposing (newUrl)

import Drivers.Commands exposing (..)
import Drivers.Messages exposing (Msg (..))
import Models exposing (Model)
import Rest exposing (httpErrorString)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    GetDriverDone (Ok driver) ->
      ({ model | driver = Just driver }, Cmd.none )
    GetDriverDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
    GetDriversDone (Ok response) ->
      ({ model |
        drivers = response.results,
        driversCount = response.count,
        driversNextPage = response.next,
        driversPreviousPage = response.previous
      }, Cmd.none )
    GetDriversDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
    NewUrl url ->
      ( model, newUrl url )
    NextPageClicked ->
      -- @todo append to model.driversQuery to maintain filters
      ( model, getDriversNextPage model )
    PrevPageClicked ->
      -- @todo append to model.driversQuery to maintain filters
      ( model, getDriversPreviousPage model )
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