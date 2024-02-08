%dw 2.0 
input payload application/json
output application/json
fun renameKey(key: Key) = key match {
    case "private" -> "isPrivate"
    case "object" -> "obj"
    case "currency" -> "currency_x"
    // TODO: Complete list of Apex reserved keywords https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_reserved_words.htm
    else -> (key)
}
--- 
payload map (record) -> (
    record mapObject (value, key, index) -> {
        (renameKey(key)) : value
    }
)