# README

## Setup
- Run `bundle`
- Run `rails db:{create,migrate}`

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

## Merchant Endpoints
#### List of Invoices
HTTP Request: `GET /api/v1/merchants`

#### Individual Merchant
HTTP Request: `GET /api/v1/merchants/{id}`

#### Find Single Merchant
HTTP Request: `GET /api/v1/merchants/find?{parameters}`

| Parameter  | Description                                |
|------------|--------------------------------------------|
| id         | search based on the merchant's primary key |
| name       | search based on the merchant's name        |
| created_at | search based on the time created at        |
| updated_at | search based on the time updated at        |


#### Find All Invoices
HTTP Request: `GET /api/v1/merchants/find_all?{parameters}`

| Parameter  | Description                                |
|------------|--------------------------------------------|
| id         | search based on the merchant's primary key |
| name       | search based on the merchant's name        |
| created_at | search based on the time created at        |
| updated_at | search based on the time updated at        |

#### Return Merchant Items
HTTP Request: `GET /api/v1/merchants/{merchant id}/items`

#### Return Merchant invoices
HTTP Request: `GET /api/v1/merchants/{merchant id}/invoices`

### Merchant Business Logic

#### Return Top Invoices by Total Revenue
HTTP Request: `GET /api/v1/merchants/most_revenue?quantity={number of merchants}`

#### Return Top Invoices by Most Items Sold
HTTP Request: `GET /api/v1/merchants/most_items?quantity={number of merchants}`

#### Return Total Revenue by Date
HTTP Request: `GET /api/v1/merchants/revenue?date={date}`

Date Format: `2012-03-23`

#### Return Total Revenue for Merchant
HTTP Request: `GET /api/v1/merchants/{merchant id}/revenue`

#### Return Total Revenue for Merchant by Date
HTTP Request: `GET /api/v1/merchants/{merchant id}/revenue?date={date}`

Date Format: `2012-03-23`

#### Return Merchant's Favorite Customer
HTTP Request: `GET /api/v1/merchants/{merchant id}/favorite_customer`

## Invoice Endpoints
#### List of Invoices
HTTP Request: `GET /api/v1/invoices`

#### Individual Invoice
HTTP Request: `GET /api/v1/invoices/{id}`

#### Find Single Invoice
HTTP Request: `GET /api/v1/invoices/find?{parameters}`

| Parameter  | Description                                |
|------------|--------------------------------------------|
| id         | search based on the invoice's primary key |
| customer_id       | search based on the invoice's customer        |
| merchant_id       | search based on the invoice's merchant        |
| status       | search based on the invoice's status        |
| created_at | search based on the time created at        |
| updated_at | search based on the time updated at        |


#### Find All Invoices
HTTP Request: `GET /api/v1/invoices/find_all?{parameters}`

| Parameter  | Description                                |
|------------|--------------------------------------------|
| id         | search based on the invoice's primary key |
| customer_id       | search based on the invoice's customer        |
| merchant_id       | search based on the invoice's merchant        |
| status       | search based on the invoice's status        |
| created_at | search based on the time created at        |
| updated_at | search based on the time updated at        |

#### Return Invoice's Transactions
HTTP Request: `GET /api/v1/invoices/{invoice id}/transactions`

#### Return Invoice's Invoice_Items
HTTP Request: `GET /api/v1/invoices/{invoice id}/invoice_items`
