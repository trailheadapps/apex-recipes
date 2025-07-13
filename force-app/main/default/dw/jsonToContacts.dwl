%dw 2.0
input records application/json
output application/apex
---
records map(record) -> {
    FirstName: record.first_name,
    LastName: record.last_name,
    Email: record.email
} as Object {class: "Contact"}