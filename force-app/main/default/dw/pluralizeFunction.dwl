%dw 2.0
import dw::core::Strings
input inputs application/json
output application/json
---
inputs map (value, index) -> (value):Strings::pluralize(value)