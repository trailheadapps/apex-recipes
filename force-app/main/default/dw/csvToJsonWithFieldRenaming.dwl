%dw 2.0 
input payload application/csv
output application/json
fun renameKey(key: Key) = key match {
    case "first_name" -> "FirstName"
    case "last_name" -> "LastName"
    case "company" -> "Company"
    case "phone1" -> "HomePhone"
    case "phone" -> "Phone"
    case "email" -> "Email"
    case "date" -> "DateofBirth"
    case "address" -> "MailingStreet"
    case "city" -> "MailingCity"
    case "county" -> "MailingCountry"
    case "state" -> "MailingState"
    case "zip" -> "MailingPostalCode"
    else -> (key)
}
--- 
payload map (contact) ->
contact mapObject (value, key) -> {
    (renameKey(key)) : value
}