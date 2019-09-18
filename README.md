# README

## Getting started

Run `bundle install` to install dependencies
Run `bundle exec rails s` to start the server

## Testing

All tests are stored under the `spec/` folder. To run the suite, use the command `bundle exec rspec`

## Instructions 

The challenge is to build a simple lab API that can return some basic details on a 'test panel'. A test panel is merely a colletion of different tests that can be run in one go. Create an endpoint that will return a JSON representation of a test panel given a test panel ID e.g. 'TP1' The TestPanel class and the Test class both include a DATA constant that holds the data about each record. The response format should adhere to the [JSON API spec.](http://jsonapi.org/examples/) For the purposes of this exercise, you should avoid using any external libraries to build the response. 

The response should include the following attributes: 
* Price 
* Sample tube type(s) (calculated from associated tests) 
* Total sample volume requirement (calculated from associated tests) 

It should also provide some information about the associated tests themselves in a 'relationship' field. For example, a request to the API with ID 'TP2' should return the following JSON

```json
{
  "data": {
    "type": "test_panels",
    "id": "TP2",
    "attributes": {
      "price": 2100,
      "sample_tube_types": ["purple", "yellow"],
      "sample_volume_requirement": 220
    },
    "relationships": {
      "test": {
        "data": [
          { "id": "B12", "type": "test"},
          { "id": "HBA1C", "type": "test"}
        ]
      }
    }
  }
}
```

The endpoint should also support an 'include' query parameter that returns an 'included' field along with the response. e.g. '...?include=test' should return the following response:

```json
{
 "data": {
    "type": "test_panels",
    "id": "TP2",
    "attributes": {
      "price": 2100,
      "sample_tube_types": ["purple", "yellow"],
      "sample_volume_requirement": 220
    },
    "relationships": {
      "test": {
        "data": [
          { "id": "B12", "type": "test"},
          { "id": "HBA1C", "type": "test"}
        ]
      }
    }
  },
  "included": [
    {
      "type": "test",
      "id": "B12",
      "attributes": {
        "name": "Vitamin B12",
        "sample_volume_requirement": 180,
        "sample_tube_type": "yellow"
      }
    },
    {
      "type": "test",
      "id": "HBA1C",
      "attributes": {
        "name": "HbA1C",
        "sample_volume_requirement": 40,
        "sample_tube_type": "purple"
      }
    }
  ]
}
```

Things to consider: 
* What happens if we pass and ID that doesn't match any existing test panel? 
* What if we pass an invalid 'include' query parameter? 
* How do we make sure everything is working?

Notes:
* Feel free to install and use any external libraries that support your solution but don't use an external library to solve the problem itself.
* You shouldn't spend too long on this exercise (max ~ 2 hours), don't worry if you don't complete it, it's far more important that you structure your solution well. If you'd like to provide some more information on how you would have completed, or any other notes, please add these to a NOTES.md file at the root of the project.

## Submitting your answer

Please clone the repo and make any changes locally. After you have finished, create a .zip of the whole project and send as an attachment to your contact at Thriva.

**Feel free to ask any questions, however small!**
