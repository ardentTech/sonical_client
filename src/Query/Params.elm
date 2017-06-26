module Query.Params exposing (find)


add : QueryParam -> List QueryParam -> List QueryParam
add param params =
  param :: params


find : String -> List QueryParam -> Maybe QueryParam
find key params =
  Nothing
