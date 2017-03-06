module Views exposing (view)

import Html exposing (Html, div, table, tbody, td, text, thead, th, tr)
import Html.Attributes exposing (class, id, title)
import List exposing (map)

import Messages exposing (Msg)
import Models exposing (Driver, FrequencyResponse, Model)
import TypeConverters exposing (maybeNumToString)


view : Model -> Html Msg
view model = 
  div [ id "drivers" ] [
    table [ class "table table-responsive table-sm table-striped" ] [
      thead [] [ tableHeaderRow ],
      tbody [] (map tableBodyRow model.drivers)
    ],
    pagination model
  ]


-- PRIVATE

frequencyResponseCell : Driver -> Html Msg
frequencyResponseCell driver =
  let
    lower = maybeNumToString <| driver.frequency_response.lower
    upper = maybeNumToString <| driver.frequency_response.upper
    str = lower ++ "-" ++ upper ++ "Hz"
  in
    td [] [ text str ] 


manufacturerCell : Driver -> Html Msg
manufacturerCell driver =
  td [] [ text driver.manufacturer.name ]


modelCell : Driver -> Html Msg
modelCell driver =
  td [] [ text driver.model ]


nominalImpedanceCell : Driver -> Html Msg
nominalImpedanceCell driver =
  let
    str = (maybeNumToString driver.nominal_impedance) ++ "Ω"
  in
    td [] [ text str ]


pagination : Model -> Html Msg
pagination model =
  case (String.isEmpty model.driversNextPage) of
    True -> div [] []
    False -> div [] []


powerCell : Driver -> Html Msg
powerCell driver =
  let
    watts = "W"
    max_power = (maybeNumToString driver.max_power) ++ watts
    rms_power = (maybeNumToString driver.rms_power) ++ watts
    str = max_power ++ ", " ++ rms_power
  in
    td [ ] [ text str ]


resonantFrequencyCell : Driver -> Html Msg
resonantFrequencyCell driver =
  let
    str = (maybeNumToString driver.resonant_frequency) ++ "Hz"
  in
    td [] [ text str ]


sensitivityCell : Driver -> Html Msg
sensitivityCell driver =
  let
    str = (maybeNumToString driver.sensitivity) ++ "db 1W\1m"
  in
    td [] [ text str ]


tableBodyRow : Driver -> Html Msg
tableBodyRow driver =
  let
    cells = [
      manufacturerCell,
      modelCell,
      nominalImpedanceCell,
      resonantFrequencyCell,
      frequencyResponseCell,
      sensitivityCell,
      powerCell
    ]
  in
    tr [] (map (\c -> c driver) cells)


tableHeaderRow : Html Msg
tableHeaderRow =
  tr [] [
    th [] [ text "Manufacturer" ],
    th [] [ text "Model" ],
    th [ title "Nominal Impedance" ] [ text "Z" ],
    th [ title "Resonant Frequency" ] [ text "Fs" ],
    th [] [ text "Sensitivity" ],
    th [ title "Frequency Response" ] [ text "Fr" ],
    th [ title "Max, RMS" ] [ text "Power"]
  ]
