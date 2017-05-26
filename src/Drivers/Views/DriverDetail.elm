module Drivers.Views.DriverDetail exposing (driverDetail)

import Html exposing (Html, a, div, h3, h5, table, tbody, td, text, tr)
import Html.Attributes exposing (class, href, target)

import Drivers.Models exposing (Driver, DriverProductListing, FrequencyResponse)
import Manufacturing.Models exposing (Material)
import Messages exposing (Msg (..))
import Models exposing (Model)
import TypeConverters exposing (..)
import Units exposing (..)
import Views.Loading exposing (loading)


driverDetail : Model -> Html Msg
driverDetail model =
  case model.driver of
    Just d -> withDriver d
    Nothing -> loading


-- PRIVATE


driverRows : Driver -> List (Html Msg)
driverRows driver =
  [
    row "Basket Frame" (formatMaterialName driver.basket_frame),
    row "BL Product" (numAppendUnit (maybeFloatToFloat driver.bl_product) tesla_meters),
    row "Compliance Equivalent Volume" (numAppendUnit (maybeFloatToFloat driver.compliance_equivalent_volume) feet_cubed),
    row "Cone" (formatMaterialName driver.cone),
    row "Cone Surface Area" (numAppendUnit (maybeFloatToFloat driver.cone_surface_area) centimeters_squared),
    row "DC Resistance" (numAppendUnit (maybeFloatToFloat driver.dc_resistance) ohms),
    row "Diaphragm Mass Including Airload" (numAppendUnit (maybeFloatToFloat driver.diaphragm_mass_including_airload) grams),
    row "Electromagnetic Q" (toString <| maybeFloatToFloat driver.electromagnetic_q),
    row "Frequency Response" (formatFrequencyResponse driver.frequency_response),
    row "Magnet" (formatMaterialName driver.magnet),
    row "Manufacturer" driver.manufacturer.name,
    row "Max Linear Excursion" (numAppendUnit (maybeFloatToFloat driver.max_linear_excursion) millimeters),
    row "Max Power" (numAppendUnit (maybeIntToInt driver.max_power) watts),
    row "Mechanical Compliance of Suspension" (numAppendUnit (maybeFloatToFloat driver.mechanical_compliance_of_suspension) millimeters_newton),
    row "Mechanical Q" (toString <| maybeFloatToFloat driver.mechanical_q),
    row "Model" driver.model,
    row "Nominal Diameter" (numAppendUnit (maybeFloatToFloat driver.nominal_diameter) inches),
    row "Nominal Impedance" (numAppendUnit (maybeIntToInt driver.nominal_impedance) ohms),
    row "Resonant Frequency" (numAppendUnit (maybeFloatToFloat driver.resonant_frequency) hertz),
    row "RMS Power" (numAppendUnit (maybeIntToInt driver.rms_power) watts),
    row "Sensitivity" (numAppendUnit (maybeFloatToFloat driver.sensitivity) decibels),
    row "Surround" (formatMaterialName driver.surround),
    row "Voice Coil Diameter" (numAppendUnit (maybeFloatToFloat driver.voice_coil_diameter) inches),
    row "Voice Coil Former" (formatMaterialName driver.voice_coil_former),
    row "Voice Coil Inductance" (numAppendUnit (maybeFloatToFloat driver.voice_coil_inductance) millihenries),
    row "Voice Coil Wire" (formatMaterialName driver.voice_coil_wire)
  ]


findDriver : List Driver -> Int -> Maybe Driver
findDriver drivers id =
  List.head <| List.filter (\d -> d.id == id) drivers


formatFrequencyResponse : Maybe FrequencyResponse -> String
formatFrequencyResponse fr =
  let
    val = case fr of
      Just f -> (toString f.lower) ++ "-" ++ (toString f.upper) ++ hertz
      Nothing -> ""
  in
    val


formatMaterialName : Maybe Material -> String
formatMaterialName material =
  let
    val = case material of
      Just m -> m.name
      Nothing -> ""
  in
    val


productListingRows : List DriverProductListing -> List (Html Msg)
productListingRows listings =
  let
    toDealer = \l -> [ a [ 
      href (l.dealer.website ++ l.path), target "_blank" ] [
      text (l.dealer.name)]]
    toPrice = \l -> [ text (dollars ++ (toString l.price))]
  in
    List.map (\l -> tr [] [ td [] (toPrice l), td [] (toDealer l)]) listings


row : String -> String -> Html Msg
row label value =
  tr [] [ td [] [ text label ], td [] [ text value ]]


withDriver : Driver -> Html Msg
withDriver driver =
  let
    view = case driver.driver_product_listings of
      Just l -> withProductListings driver l
      Nothing -> withoutProductListings driver
  in
    div [] [
      h3 [] [ text (driver.manufacturer.name ++ " " ++ driver.model) ],
      view
    ]


withProductListings : Driver -> List DriverProductListing -> Html Msg
withProductListings driver productListings =
  div [ class "row" ] [ 
    div [ class "col-8" ] [
      table [ class "table table-sm table-striped" ] [ tbody [] (driverRows driver) ]
    ],
    div [ class "col-4" ] [
      h5 [] [ text "Purchase Now" ],
      table [ class "table table-sm table-striped" ] [ tbody [] (
        productListingRows productListings) ]
    ]
  ]


withoutProductListings : Driver -> Html Msg
withoutProductListings driver =
  table [ class "table table-sm table-striped" ] [ tbody [] (driverRows driver) ]
