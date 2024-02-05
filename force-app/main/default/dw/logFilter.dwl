%dw 2.0
input payload application/json
output application/json
---
payload filter ((value) -> log(value).isWinner == true) 