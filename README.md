# README

## Setup
- Run `bundle`

## Importing CSV Data
- To import all CSV data run `rake import:all`
- To import individual CSVs run `rake import:'csv_file'` where 'csv_file' can be:
  - merchants
  - items
  - customers
  - invoices
  - invoice_items
  - transactions
  - Example: `rake import:merchants`
