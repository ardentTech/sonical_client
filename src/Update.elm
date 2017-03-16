module Update exposing (update)

import Debounce exposing (Debounce)

import Commands exposing (getDrivers, searchDrivers)
import Config exposing (debounceConfig)
import Messages exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      DebounceMsg msg ->
        let
          (debounce, cmd) = Debounce.update
            debounceConfig
            (Debounce.takeLast (searchDrivers model))
            msg
            model.debounce
        in
          ({ model | debounce = debounce}, cmd )
      Fail _ ->
        ( model, Cmd.none )
      GetDriversDone (Ok response) ->
        ({ model |
          drivers = response.results,
          driversCount = response.count,
          driversNextPage = response.next,
          driversPreviousPage = response.previous
        }, Cmd.none )
      GetDriversDone (Err _) ->
        ( model, Cmd.none )
      NextPageClicked ->
        ( model, getDrivers model model.driversNextPage )
      NoOp ->
        ( model, Cmd.none )
      PrevPageClicked ->
        ( model, getDrivers model model.driversPreviousPage )
      QueryInput q ->
        let
          (debounce, cmd) = Debounce.push debounceConfig q model.debounce
        in
          ({ model | debounce = debounce, driversQuery = q }, cmd)
      SetTableState newState ->
        ({ model | tableState = newState }, Cmd.none )
