%dw 2.0
input records application/java
output application/json
--- 
{
    users: records map(record) -> {
        firstName: record.FirstName,
        lastName: record.LastName,
        // https://docs.mulesoft.com/dataweave/2.4/dataweave-cookbook-format-dates
        createdDate: (record.CreatedDate >> "UTC") as String {format: "hh:mm:ss a, MMMM dd, uuuu"} 
    }
}