%dw 2.0 
// This example is taken from:
// https://docs.mulesoft.com/dataweave/2.5/dataweave-cookbook-reference-multiple-inputs
// More on DataWeave formats:
// https://docs.mulesoft.com/dataweave/2.5/dataweave-formats
input products application/json
input attributes application/json
input exchangeRates application/json
output application/xml
--- 
books: {
    (products filter ($.properties.year > attributes.publishedAfter) map  (item)   ->  {
        book @(year: item.properties.year): {
            (exchangeRates.USD map {
                price @(currency: $.currency): $.ratio * item.price
            }),
            title: item.properties.title,
            authors: { (item.properties.author map {
                author: $
            }) }
        }
    } )
}