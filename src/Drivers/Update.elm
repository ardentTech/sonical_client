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
        newModel = { model |
          drivers = response.results,
          driversCount = response.count,
          driversNextOffset = offsetFromUrl response.next,
          driversPreviousOffset = offsetFromUrl response.previous
        }
      in
        ( newModel, Cmd.none )
    GetDriversDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
    NextPageClicked ->
      -- @todo append to model.driversQuery to maintain filters
      ( model, Cmd.none )
    PrevPageClicked ->
      -- @todo append to model.driversQuery to maintain filters
      ( model, Cmd.none )
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
