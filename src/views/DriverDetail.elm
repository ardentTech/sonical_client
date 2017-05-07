module Views.DriverDetail exposing (driverDetail)

import Html exposing (Html, div, h3, text)
import Html.Attributes exposing (class)
import Table exposing (defaultCustomizations, stringColumn)

import Messages exposing (Msg (..))
import Models exposing (Driver, Model)
import Units exposing (decibels, hertz, inches, ohms, watts)
import Views.Table exposing (
  manufacturerColumn, maybeFloatColumn, maybeIntColumn)

driverDetail : Model -> Int -> Html Msg
driverDetail model id =
  let
    txt = case (findDriver model.drivers id) of
      Just d -> d.manufacturer.name ++ " " ++ d.model
      Nothing -> "Something went wrong"
  in
    div [] [ h3 [] [ text txt ]]


-- PRIVATE


findDriver : List Driver -> Int -> Maybe Driver
findDriver drivers id =
  List.head <| List.filter (\d -> d.id == id) drivers


-- @todo add frequency_response
tableConfig : Table.Config Driver Msg
tableConfig =
  Table.customConfig {
    toId = .model,
    toMsg = SetTableState,
    columns = [
      manufacturerColumn,
      maybeIntColumn "Max Power" .max_power watts,
      stringColumn "Model" .model,
      maybeFloatColumn "Nominal Diameter" .nominal_diameter inches,
      maybeIntColumn "Nominal Impedance" .nominal_impedance ohms,
      maybeFloatColumn "Resonant Frequency" .resonant_frequency hertz,
      maybeFloatColumn "Sensitivity" .sensitivity decibels,
      maybeIntColumn "RMS Power" .rms_power watts
    ],
    customizations = {
      defaultCustomizations | tableAttrs = [ class "table table-sm table-striped" ]
    }
  }
