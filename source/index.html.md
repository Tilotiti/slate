---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell: cURL

toc_footers:
  - <a href='https://www.fidcar.com'>FIDCAR</a>
  - <a href='https://www.fidcar.com/fr/pro/group/tool/api'>Get your API key</a>

includes:
  - errors

search: true
---

# Introduction

The FIDCAR API is organized around [REST](https://en.wikipedia.org/wiki/Representational_state_transfer). Our API has predictable, resource-oriented URLs, and uses HTTP response codes to indicate API errors. We use built-in HTTP features, like HTTP authentication and HTTP verbs, which are understood by off-the-shelf HTTP clients. [JSON](http://www.json.org/) is returned by all API responses, including errors

# Authentication

> To authorize, use this code:


```shell
# With shell, you can just pass the correct header with each request
curl "https://www.fidcar.com/api/"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key.

FIDCAR API use  keys to allow access to the API. You can retrieve your API key at our [Tools Page](https://www.fidcar.com/fr/pro/group/tool/api).

FIDCAR expects for the API key to be included in all API requests to the server in a header that looks like the following:

`Authorization: [api_key]`

<aside class="notice">
You must replace <code>api_key</code> with your personal API key.
</aside>

# Pagination

All ressources have support for bulk fetches via "list" API methods. For instance, you can [list dealerships](#list-all-the-dealerships). These list API methods share a common structure, taking at least these two parameters : `page` and `limit`.

## Query Parameters


```shell
curl "https://www.fidcar.com/api/local?page=3&limit=5"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key.


Parameter | Default | Description
----------|---------|-------------
`page` | 1 | The cursor used in pagination (optional).
`limit` | 10 | A limit on the number of objects to be returned, between 1 and 100 (optional).

## List Response Format

```js
{
  "page": 3,
  "limit": 5,
  "total": 25,
  "data": [
    object,
    object,
    object,
    object,
    object
  ]
}
```

Key | Description
----|-------------
`page` | Pagination Cursor
`limit` | Pagination Limit
`total` | Total Count of objects
`data` | Array of paginated objects

# Dealership

```js
{
    "id": 1325,
    "code": "DCUZ1123",
    "publicKey": "4a5bc929b3a8a2a23cca0ba5985dazzd3",
    "title": "Garage Automobiles du Nord",
    "street": "13 rue du Général Leclerc",
    "zipcode": "78310",
    "city": "Villerain sur Seine",
    "country": "FR",
    "coords": [
        "48.26900",
        "-1.11800"
    ],
    "phone": "01 69 65 24 02",
    "website": "http://www.garage-automobile-du-nord.fr/",
    "siret": "81426458802142",
    "grade": "9.40",
    "url": "https://www.fidcar.dev/app_dev.php/fr/local/1325/garage-automobile-du-nord",
    "reviews": 231,
    "brands": [
        "BMW",
        "Mini"
    ],
    "social": {
        "facebook": "6.70",
        "google": "7.90",
        "pagesjaunes": false
    },
    "bridge": bridge // Bridge object
}
```

This object represent a dealership assigned to your account.

Key | Type | Description
----------|------|-------------
`id` | integer | Unique identifier for the object.
`code` | string | Internal dealership indentifier.
`publicKey` | string | The dealership public key. Used to call the widget.
`title` | string | The dealership title.
`street` | string | The dealership street name in the postal Adresse
`city` | string | The city where the dealership is located
`zipcode` | string | The city zipcode
`country` | string | The country code (2 caracters like `FR`, `EN`, `IT` or `BE`)
`coords` | array | The dealership geolocalisation : `[latitude, longitude]`
`phone` | string | The nationaly formatted dealership phone number.
`url` | string | The dealership website URL
`reviews` | integer | The number of customer reviews of the dealership
`brands` | array | The brand's names
`social` | object | The social media grades.
`bridge` | object | The dealership [Bridge object](#bridge) (optional)

## List the dealerships

You can list and filter all the `local` objects assigned to your account.

```shell
curl "https://www.fidcar.com/api/local?page=1&limit=5&bridge=icar"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key.

### HTTP Request

`GET https://www.fidcar.com/api/local`

### Query Parameters

Parameter | Default | Description
----------|---------|-------------
`page` | 1 | The cursor used in the pagination (optional)
`limit` | 10 | A limit on the number of `local` object to be returned, between 1 and 100 (optional)
`siret` | | Filter by the SIRET number of the dealership (optional)
`code` | | Filter by the internal code of the dealership (optional)
`bridge` | | Filter by the `code` parameter of the dealership [`bridge` object](#bridge) (optional).

### Response

The API answer with a [`Pagination` object](#pagination) containing an array of [`local` object](#dealership) in `data`.

## Get a dealership

Get the details of one of your dealership.

### HTTP Request

```shell
curl "https://www.fidcar.com/api/local/[local_id]"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key and `[local_id]` by the dealership unique identifier.

`GET https://www.fidcar.com/api/local/[local_id]`

<aside class="notice">
You must replace <code>[local_id]</code> with the dealership unique identifier <code>id</code>.
</aside>

### Response

The API answer with the [`local` object](#dealership) asked. 

## Create a dealership

You can create a`local` objects assigned to your account.

```shell
curl "https://www.fidcar.com/api/local/add"
  -H "Authorization: [api_key]"
  -F title="Garage Caltagirone"
  -F street="16 place des Vosges"
  -F zipcode=75004
  -F city=Paris
  -F country=FR
  -F phone=0176420140
  -F code=DCU4897
  -F siret=1234567891245
  -F type=dealer
  -F url="https://www.fidcar.com"
  -F plan=classic_monthly
  -F sms=1
  -F services[]=sav
  -F services[]=vo
  -F services[]=vn
  -F brands[]=Renault
  -F brands[]=Dacia
```

> Make sure to replace `[api_key]` with your API key.

### HTTP Request

`POST https://www.fidcar.com/api/local/add`

### Query Parameters

Parameter | Type | Description
----------|---------|-------------
`code` | string | Internal dealership indentifier. (optional)
`title` | string | The dealership title.
`street` | string | The dealership street name in the postal Adresse
`city` | string | The city where the dealership is located
`zipcode` | string | The city zipcode
`country` | string | The country code (2 caracters like `FR`, `EN`, `IT` or `BE`, `FR` by default)
`phone` | string | The nationaly formatted dealership phone number.
`siret` | string | The dealership Siret indentifier. (optional)
`url` | string | The dealership website URL (optional)
`plan` | string | The subscription plan `classic_monthly` (84€ / month) or `social_monthly` (19€ / month) (`classic_monthly` by default)
`sms` | bool | Activate the SMS option (`false` by default)
`services` | array | The services codes name to activate (`sav` by default)
`brands` | array | The brand's names (optional)

### Response

The API answer with a [`Local` object](#dealership).

# Contact

```js
{
    "id": "d57c6ec6-4ebd-4a01-a6fd-9771638424c9",
    "user": user, // Object user
    "pro": false,
    "service": "sav",
    "datetime": "2017-10-10 18:00:30",
    "review": review, // Object review
    "communication": [
        communication, // Object communication
        communication, // Object communication
        communication, // Object communication
        communication // Object communication
    ],
    "brand": 'Volvo',
    "model": 'XC 60',
    "seller": 'Quentin Porcet',
    "immat": "AZ-232-DZ",
    "vin": "ABC4513321K05ZDHA",
    "km": 239143,
    "mec": "2015-10-01",
    "origin": "web"
}
```

This object represent a Contact assigned to one of your Dealership.

Key | Type | Description
----------|------|-------------
`id` | string | Contact Unique Identifier
`user` | object | The contact personal information, an [`user`](#user) object
`reference` | string | The contact internal reference in the Dealership system.
`pro` | bool | Is the contact a professionnal ? (`false` by default)
`service` | string | The code of the service used by the contact (optional).
`datetime` | string | The date and time of the purchase in the dealership or the creation of the contact.
`review` | string | The review writed by the contact
                                                  
ct about your dealership, an [`review`](#review) object (optional).
`communication` | array | An array of [`communication`](#communication) object.
`seller` | string | The name of his seller (optional)
`type` | string | Type of it vehicle (`auto` or `moto`, optional).
`brand` | string | The brand of his car (optional).
`model` | string | The model of his car (optional).
`immat` | string | The vehicule immatriculation number (optional)
`vin` | string | The VIN number / Serial Number (optional)
`km` | string | The mileage (optional)
`mec` | string | The date of first circulation (optional - Y-m-d)
`origin` | string | The origin of the contact (optional)
`price` | int | The price billed to the customer (optional)
`status` | string | The current status of the contact

The differents status are :

Status | Description
-------|------------
contactable | The contact will be sent an email or an SMS.
missing | The contact is not complete, an email or an SMS is needed.
too_soon | The contact already has been reached the last month on this dealership.
disabled | The contact already tell that he doesn't wanted to be reached again.


The differents services are :

Service | Description
--------|-------------
vo | Purchase of used car
vn | Purchase of new car
sav | After sales service
rent | Rent service

## List the contact

You can list and filter all your `contact` objects.

```shell
curl "https://www.fidcar.com/api/contact?page=1&limit=5"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key and `[local_id]` with the dealership unique identifier.

### HTTP Request

`GET https://www.fidcar.com/api/contact`

### Query Parameters

Parameter | Default | Description
----------|---------|-------------
`page` | 1 | The cursor used in the pagination (optional).
`limit` | 10 | A limit on the number of `contact` object to be returned, between 1 and 100 (optional).
`name` | | Filter by the contact fullname (optional).
`firstname` | | Filter by the contact `user` firstname (optional).
`lastname` | | Filter by the contact `user` lastname (optional).
`email` | | Filter by the contact `user` email (optional).
`phone` | | Filter by the contact `user` phone (optional).
`start` | | Filter by the date of purchase after `start` (YYYY-MM-DD) (optional).
`end` | | Filter by the date of purchase before `end` (YYYY-MM-DD) (optional).
`grade` | | Filter by the grade of the contact `review`. You can use an integer like `8` for filtering by all the `review` graded 8/10, filter with `>6` for filtering all the `review` graded strictely better than 6/10, filter with `<7` for filtering all the `review` graded strictely worst than 7/10 or filter with `all` for having only the contacts with a review. (optional).
`siret` | | Filter by the `local` siret (optional).
`origin` | | Filter by the `contact` origin (optional).
`service` | | Filter by the `contact` service (optional).

### Response

The API answer with a [`Pagination` object](#pagination) containing an array of [`contact` object](#contact) in `data`.

## List the contact of a dealership

You can list and filter all the `contact` objects assigned to one of your dealership.

```shell
curl "https://www.fidcar.com/api/local/[local_id]/contact?page=1&limit=5"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key and `[local_id]` with the dealership unique identifier.

### HTTP Request

`GET https://www.fidcar.com/api/local/[local_id]/contact`

<aside class="notice">
You must replace <code>[local_id]</code> with the dealership unique identifier <code>id</code>.
</aside>

### Query Parameters

Parameter | Default | Description
----------|---------|-------------
`page` | 1 | The cursor used in the pagination (optional).
`limit` | 10 | A limit on the number of `contact` object to be returned, between 1 and 100 (optional).
`name` | | Filter by the contact fullname (optional).
`firstname` | | Filter by the contact `user` firstname (optional).
`lastname` | | Filter by the contact `user` lastname (optional).
`email` | | Filter by the contact `user` email (optional).
`phone` | | Filter by the contact `user` phone (optional).
`start` | | Filter by the date of purchase after `start` (YYYY-MM-DD) (optional).
`end` | | Filter by the date of purchase before `end` (YYYY-MM-DD) (optional).
`grade` | | Filter by the grade of the contact `review`. You can use an integer like `8` for filtering by all the `review` graded 8/10, filter with `>6` for filtering all the `review` graded strictely better than 6/10, filter with `<7` for filtering all the `review` graded strictely worst than 7/10 or filter with `all` for having only the contacts with a review. (optional).
`origin` | | Filter by the `contact` origin (optional).

### Response

The API answer with a [`Pagination` object](#pagination) containing an array of [`contact` object](#contact) in `data`.

## Add a new contact

You can add a new `contact` object to one of your dealership. This will trigger the FIDCAR processus by creating `communication` object as planning in the dealership configuration. You must fill either the contact's email or phone number.

```shell
curl "https://www.fidcar.com/api/local/[local_id]/contact"
  -H "Authorization: [api_key]"
  -F firstname=Thibault
  -F lastname=Henry
  -F email=thibault@fidcar.com
  -F phone=0672391759
  -F service=sav
```

> Make sure to replace `[api_key]` with your API key and `[local_id]` with the dealership unique identifier.

### HTTP Request

`POST https://www.fidcar.com/api/local/[local_id]/contact`

<aside class="notice">
You must replace <code>[local_id]</code> with the dealership unique identifier <code>id</code>.
</aside>

### Query Parameters

Parameter | Default | Description
----------|---------|-------------
`firstname` | | The contact firstname.
`lastname` | | Filter by the contact lastname.
`email` | | The contact email (optional).
`phone` | | The contact phone (optional).
`pro` | false | Is the contact a professionnal ? (`false` by default)
`service` | | The name of the service used by the contact (optional).
`seller` | | The name of his seller (optional)
`type` | `auto` | Type of it vehicle (`auto` or `moto`, optional).
`brand` | | The brand of his car (optional).
`model` | | The model of his car (optional).
`immat` | | The vehicule immatriculation number (optional)
`vin` | | The VIN number / Serial Number (optional)
`km` | | The mileage (optional)
`mec` | | The date of first circulation (optional - Y-m-d)
`origin` | | The origin of the contact (optional)
`date` | `now` | The date of the purchase (optional - `Y-m-d`, `d/m/Y`)
`hour` | `now` | The hour of the purchase (optional - `H:i`)
`price` | `0` | The price billed to the customer (optional - `integer`)
 

### Response

The API answer with the new [`contact`](#contact) object created.

# Review

```js
{
    "id": "d57c6ec6-4ebd-4a01-a6fd-9771638424c9",
    "user": user, // Object user
    "contact": contact, // Object contact
    "datetime": "2017-10-10 18:00:30",
    "service": "sav",
    "grade": 10,
    "comment": "Personnel agréable et compétent",
    "survey": {
        "Accueil": 10,
        "Explications": 10,
        "Essai": 1,
        "Livraison": 8
    },
    "answer": answer, // answer object
    "status": "published"
}
```

This object represent a Review submitted about one of your Dealership.

Key | Type | Description
----------|------|-------------
`id` | string | Review Unique Identifier.
`user` | object | The [`user`](#user) object who posted the review.
`contact` | object | The [`contact`](#contact) object (without the [`user`](#user) parameter).
`datetime` | string | The date and time of the review.
`service` | string | The code of the service used by the contact.
`grade` | int | The grade of the review (from 1 to 10).
`comment` | string | The content of the review.
`survey` | object | The list of additionnal appreciations (optional).
`answer` | object | The [`answer`](#answer) object (optional).
`status` | string | Always "`published`".

## List the reviews

You can list and filter the `review` objects assigned to one of your dealership.

```shell
curl "https://www.fidcar.com/api/review?page=1&limit=5"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key.

### HTTP Request

`GET https://www.fidcar.com/api/review`

### Query Parameters

Parameter | Default | Description
----------|---------|-------------
`page` | 1 | The cursor used in the pagination (optional)
`limit` | 10 | A limit on the number of `review` object to be returned, between 1 and 100 (optional)
`local` | | Filter by the the `local` unique identifier (optional).
`start` | | Filter by the date of `review` after `start` (Y-m-d H:i:s) (optional).
`end` | | Filter by the date of `review` before `end` (Y-m-d H:i:s) (optional).

### Response

The API answer with a [`Pagination` object](#pagination) containing an array of [`review` object](#review) in `data`.

## Get a review

Get the details of one of your review.

### HTTP Request

```shell
curl "https://www.fidcar.com/api/review/[review_id]"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key and `[review_id]` by the review unique identifier.

`GET https://www.fidcar.com/api/review/[review_id]`

<aside class="notice">
You must replace <code>[review_id]</code> with the review unique identifier <code>id</code>.
</aside>

### Response

The API answer with the [`review` object](#review) asked. 

## Reply to a review

Reply to one of your review.

### HTTP Request

```shell
curl "https://www.fidcar.com/api/review/[review_id]/answer"
  -H "Authorization: [api_key]"
  -F content="Your answer."
```

> Make sure to replace `[api_key]` with your API key and `[review_id]` by the review unique identifier.

`POST https://www.fidcar.com/api/review/[review_id]/answer`

<aside class="notice">
You must replace <code>[review_id]</code> with the review unique identifier <code>id</code>.
</aside>

### Query Parameters

Parameter | Default | Description
----------|---------|-------------
`content` | | The text of your answer.

### Response

The API answer with the [`review` object](#review). 

## Report a review

Report a review to ask the support to check if it fits our guidelines.

### HTTP Request

```shell
curl "https://www.fidcar.com/api/review/[review_id]/report"
  -H "Authorization: [api_key]"
  -F message="The review is problematic"
```

> Make sure to replace `[api_key]` with your API key and `[review_id]` by the review unique identifier.

`POST https://www.fidcar.com/api/review/[review_id]/report`

<aside class="notice">
You must replace <code>[review_id]</code> with the review unique identifier <code>id</code>.
</aside>

### Query Parameters

Parameter | Default | Description
----------|---------|-------------
`message` | | The justification of your report.

### Response

The API answer with the [`review` object](#review). 

# Lead


```js
{
    "review":review, // review object
    "type": "Neuf",
    "brand": "Volvo",
    "model": "XC60",
    "delay": "6 mois"
}
```

This object represent a lead assigned to one of your Dealership.

Key | Type | Description
----------|------|-------------
`review` | object | The [`review`](#review) object.
`type` | string | Type of the lead "new" or "used", in the dealership langage.
`brand` | string | The car brand wanted by the contact (optional).
`model` | string | The car model wanted by the contact (optional).
`delay` | string | The delay wanted by the contact (in the dealership langage) (optional).

## List the leads

You can list and filter all the `lead` objects assigned to one of your dealership.

```shell
curl "https://www.fidcar.com/api/local/[local_id]/lead?page=1&limit=5"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key and `[local_id]` with the dealership unique identifier.

### HTTP Request

`GET https://www.fidcar.com/api/local/[local_id]/lead`

<aside class="notice">
You must replace <code>[local_id]</code> with the dealership unique identifier <code>id</code>.
</aside>

### Query Parameters

Parameter | Default | Description
----------|---------|-------------
`page` | 1 | The cursor used in the pagination (optional).
`limit` | 10 | A limit on the number of `contact` object to be returned, between 1 and 100 (optional).
`type` | | Filter by Type of the lead "new" or "used", in the dealership langage (optional)

### Response

The API answer with a [`Pagination` object](#pagination) containing an array of [`lead` object](#contact) in `data`.


# Dispute


```js
{
    "review": review, // review object
    "wishContact": true,
    "wishContactTime": "morging",
    "wishContactMethod": "phone",
    "user": user, // user object
    "urgent": true,
    "status": assigned,
    "createdAt": "2019-05-24T15:26:37+02:00",
    "assignedAt": "2019-05-24T17:26:37+02:00",
    "closedAt": null,
    "confirmedAt": null
}
```

This object represent a dispute between the dealership and one of the customer, following a bad review.

Key | Type | Description
----------|------|-------------
`review` | object | The [`review`](#review) object.
`wishContact` | boolean | Does the customer want to be recontacted
`wishContactTime` | string | "morning" or "afternoon" (optional).
`wishContactMethode` | string | "phone" or "email" (optional).
`user` | object| The dealership's team [`user`](#user) object assigned to the dispute (optional).
`urgent` | bool | Is the dispute qualified as urgent ? (default `false`).
`status` | string | The dispute status : `waiting` for a new dispute, `assigned` when the dispute is attributed to a team member, `closed` when a team member said that the dispute was solved, `solved` when the customer agreed that its problem was solved and `unsolved` otherwise.
`createdAt` | datetime | The datetime when the dispute has been created.
`assignedAt` | datetime | The datetime when the dispute has been assigned to a team member.
`closedAt` | datetime | The datetime when the dispute has been declared as solved by a team member.
`confirmedAt` | datetime | The datetime when the customer confirmed that the problem was solved or not.

## List the disputes

You can list and filter all the `disputes` objects assigned to one of your dealership.

```shell
curl "https://www.fidcar.com/api/dispute?page=1&limit=5"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key.

### HTTP Request

`GET https://www.fidcar.com/api/dispute?page=1&limit=5`

### Query Parameters

Parameter | Default | Description
----------|---------|-------------
`page` | 1 | The cursor used in the pagination (optional).
`limit` | 10 | A limit on the number of `dispute` object to be returned, between 1 and 100 (optional).

### Response

The API answer with a [`Pagination` object](#pagination) containing an array of [`dispute` object](#contact) in `data`.

## Get a dispute

Get the detail of a `dispute` object.

```shell
curl "https://www.fidcar.com/api/dispute/[dispute_id]"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key and the `[dispute_id]` by the unique ID of the dispute.

### HTTP Request

`GET https://www.fidcar.com/api/dispute/[dispute_id]`

### Response

The API answer with a [`dispute` object](#dispute) object.

## Close a dispute

Set a `dispute` object status as `closed` and send the email to the customer for his confirmation.

```shell
POST "https://www.fidcar.com/api/dispute/[dispute_id]/close"
  -H "Authorization: [api_key]"
```

> Make sure to replace `[api_key]` with your API key and the `[dispute_id]` by the unique ID of the dispute.

### HTTP Request

`POST https://www.fidcar.com/api/dispute/[dispute_id]/close`

### Response

The API answer with a [`dispute` object](#dispute) object.

# Other

Some objects don't have any method, but they can appear in other object as a dependency.

## Answer

```js
{
    "user": user, // user object
    "datetime": "2017-10-09 19:03:02",
    "content": "Bonjour\r\nNous vous remercions pour avoir partager votre avis. Revenez vite !"
}
```

This object represent the [`review`](#review) answer, posted online by one of the dealership user. 

Key | Type | Description
----|------|-------------
`user` | string | The [`user`](#user) who answered.
`datetime` | string | The date and time of the answer.
`content` | string | The content of the answer.

## Bridge

```json
{
    "title": "i'Car Systems",
    "code": "icar",
    "params": {
        "code_dealer": "1268"
    }
}
```

This object represent the [dealership](#dealership) automatic importation configuration.

Key | Type | Description
----------|------|-------------
`title` | string | Title of the connected software.
`code` | string | Code of the connected software.
`params` | object | The configured parameters for the software connexion. Each configuration object is different.

## Communication

```json
{
    "type": "email",
    "status": "wait",
    "datetime": "2017-10-27 15:03:00"
}
```

This object represent an SMS or an Email planned to be send to a [`contact`](#contact).

Key | Type | Description
----|------|-------------
`type` | string | `sms` or `email`.
`status` | string | The actual status of the communication sending.
`datetime` | string | The date and time of the `communication` sending.

The `status` parameter can have multiple values :

Status | Description
-------|-------------
`wait` | The communication has not been send yet.
`canceled` | The communication won't be send because the contact created a review.
`sent` | The communication has been sent.
`clicked` | The contact clicked on the communication.
`unsubscribe` | The contact requested to not receive any other communication from FIDCAR.

## User

```json
{
    "firstname": "Thibault",
    "lastname": "Henry",
    "email": "thibault@fidcar.com",
    "phone": "0672391759"
}
```

This object represent the [`contact`](#contact) personnal informations. The contact can edit those informations.

Key | Type | Description
----|------|-------------
`firstname` | string | The contact firstname.
`lastname` | string | The contact lastname.
`email` | string | The contact email address.
`phone` | string | The contact phone number.