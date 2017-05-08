module Views.DriverDetail exposing (driverDetail)

import Html exposing (Html, div, h3, table, tbody, td, text, tr)
import Html.Attributes exposing (class)

import Messages exposing (Msg (..))
import Models exposing (Driver, Model)
import TypeConverters exposing (maybeFloatToFloat, maybeIntToInt)
import Units exposing (decibels, hertz, inches, ohms, watts)

driverDetail : Model -> Int -> Html Msg
driverDetail model id =
  let
    markup = case (findDriver model.drivers id) of
      Just driver ->
        div [] [
          h3 [] [ text (driver.manufacturer.name ++ " " ++ driver.model) ],
          tableView driver
        ]
      Nothing -> div [] []
  in
    markup


-- PRIVATE


appendUnit : number -> String -> String
appendUnit n unit =
  (toString n) ++ " " ++ unit

findDriver : List Driver -> Int -> Maybe Driver
findDriver drivers id =
  List.head <| List.filter (\d -> d.id == id) drivers

-- @todo add frequency_response
-- @todo refine row generation process
tableView : Driver -> Html Msg
tableView driver =
  table [ class "table table-sm table-striped" ] [
    tbody [] [
      row "Manufacturer" driver.manufacturer.name,
      row "Max Power" (appendUnit (maybeIntToInt driver.max_power) watts),
      row "Model" driver.model,
      row "Nominal Diameter" (appendUnit (maybeFloatToFloat driver.nominal_diameter) inches),
      row "Nominal Impedance" (appendUnit (maybeIntToInt driver.nominal_impedance) ohms),
      row "Resonant Frequency" (appendUnit (maybeFloatToFloat driver.resonant_frequency) hertz),
      row "Sensitivity" (appendUnit (maybeFloatToFloat driver.sensitivity) decibels),
      row "RMS Power" (appendUnit (maybeIntToInt driver.rms_power) watts)
    ]
  ]

row : String -> String -> Html Msg
row label value =
  tr [] [ td [] [ text label ], td [] [ text value ]]
