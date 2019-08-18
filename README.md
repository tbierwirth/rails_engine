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
#### List of Merchants
HTTP Request: `GET /api/v1/merchants`

Example JSON output:
```
{
  "data": [
  {
    "id": "1",
      "type": "merchant",
      "attributes": {
        "id": 1
        "name": "Schroeder-Jerde",
      }
  },
  {
    "id": "2",
    "type": "merchant",
    "attributes": {
      "id": 2
      "name": "Klein, Rempel and Jones",
    }
  },
  {
    "id": "3",
    "type": "merchant",
    "attributes": {
      "id": 3
      "name": "Willms and Sons",
    }
  }
  ]
}
```
#### Individual Merchant
HTTP Request: `GET /api/v1/merchants/{id}`

Example JSON output:
```
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "id": 1
      "name": "Schroeder-Jerde",
    }
  }
}
```
#### Find Single Merchant
HTTP Request: `GET /api/v1/merchants/find?parameters`

| Parameter  | Description                                |
|------------|--------------------------------------------|
| id         | search based on the merchant's primary key |
| name       | search based on the merchant's name        |
| created_at | search based on the time created at        |
| updated_at | search based on the time updated at        |

Example JSON output:

`GET /api/v1/merchants/find?name=Schroeder-Jerde`
```
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Schroeder-Jerde"
    }
  }
}
```

#### Find All Merchants
HTTP Request: `GET /api/v1/merchants/find_all?parameters`

| Parameter  | Description                                |
|------------|--------------------------------------------|
| id         | search based on the merchant's primary key |
| name       | search based on the merchant's name        |
| created_at | search based on the time created at        |
| updated_at | search based on the time updated at        |

Example JSON output:

`GET /api/v1/merchants/find_all?name=Cummings-Thiel`
```
{
  "data":
  [
  {
    "id": "4",
    "type": "merchant",
    "attributes": {
      "name": "Cummings-Thiel"
    }
  }
  ]
}
```
