module Views exposing (view)

import Html exposing (Html, div)
import Table

import Messages exposing (
  Msg (NextPageClicked, PrevPageClicked, SetTableState))
import Models exposing (Driver, Model)
import TypeConverters exposing (maybeFloatToFloat, maybeIntToInt)
--import Units exposing (decibels, hertz, ohms, watts)


view : Model -> Html Msg
view model =
  div [] [ Table.view tableConfig model.tableState model.drivers ]


-- PRIVATE


manufacturerColumn : Table.Column Driver Msg
manufacturerColumn =
  let
    val = (\m -> m.name) << .manufacturer
  in
    Table.customColumn {
      name = "Manufacturer",
      viewData = val,
      sorter = Table.increasingOrDecreasingBy val
    }


maybeFloatColumn : String -> (data -> Maybe Float) -> Table.Column data Msg
maybeFloatColumn name data =
  let
    val = maybeFloatToFloat << data
  in
    Table.customColumn {
      name = name,
      viewData = toString << val,
      sorter = Table.increasingOrDecreasingBy val
    }


maybeIntColumn : String -> (data -> Maybe Int) -> Table.Column data Msg
maybeIntColumn name data =
  let
    val = maybeIntToInt << data
  in
    Table.customColumn {
      name = name,
      viewData = toString << val,
      sorter = Table.increasingOrDecreasingBy val
    }


tableConfig : Table.Config Driver Msg
tableConfig =
  Table.config {
    toId = .model,
    toMsg = SetTableState,
    columns = [
      manufacturerColumn,
      Table.stringColumn "Model" .model,
      maybeFloatColumn "Fs" .resonant_frequency,
      maybeIntColumn "Z" .nominal_impedance,
      maybeIntColumn "Max" .max_power,
      maybeIntColumn "RMS" .rms_power
    ]
  }
