module Update exposing (update)

import Debounce exposing (Debounce)
import Task exposing (Task)
import Time exposing (second)

import Commands exposing (getDrivers, searchDrivers)
import Messages exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      DebounceMsg msg ->
        let
          (debounce, cmd) = Debounce.update
            debounceConfig
            (Debounce.takeLast save)
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
        ( model, getDrivers model.driversNextPage )
      NoOp ->
        ( model, Cmd.none )
      PrevPageClicked ->
        ( model, getDrivers model.driversPreviousPage )
      SetDriversQuery q ->
        let
          (debounce, cmd) = Debounce.push debounceConfig q model.debounce
        in
          ({ model | debounce = debounce, driversQuery = q }, cmd)
      SetIt q ->
        ( model, searchDrivers q)
      SetTableState newState ->
        ({ model | tableState = newState }, Cmd.none )


-- PRIVATE

debounceConfig : Debounce.Config Msg
debounceConfig = {
  strategy = Debounce.later (1 * second),
  transform = DebounceMsg }


-- @TODO rename this
save : String -> Cmd Msg
save s =
  Task.perform SetIt (Task.succeed s)
