# Errors

FIDCAR uses conventional HTTP response codes to indicate the success or failure of an API request. In general, codes in the `2xx` range indicate success, codes in the `4xx` range indicate an error that failed given the information provided and codes `5xx` range indicate an error with FIDCAR's servers.

In case of a failure, in addition to the HTTP response code, FIDCAR API return a JSON object :

```json

{
    "error": {
      "code": 401,
      "message": "Unknown Authorization token"
    }
}
```


Error Code | Meaning
---------- | -------
400 | Bad Request
401 | Unauthorized
403 | Forbidden
404 | Not Found
405 | Method Not Allowed
406 | Not Acceptable
410 | Gone
429 | Too Many Requests
500 | Internal Server Error
503 | Service Unavailable
