/*
// ===---Description---------------------------------------------------------------===
//  Solution for the Hodor Project, Level 2 by Julien Barbier.
//  It needs the main.go file to compile.
//
//  by Alexandro de Oliveira, for Holberton School
// ===-----------------------------------------------------------------------------===
*/
package main

import (
	"net/http"
	"net/url"
)

var cookie = "564599e6478332473dbb28a942390d163cd79e26"

//===--Function parsedURL()------------------------------------------------===//
// parsedURL() is used to define the URL.
// I chose to split each item(parse) in order to have more control on them.
// To obtain this result you can use url.Parse(URL) in a raw URL, which will
// return an object of type url.URL that is defined by a struct.
//===----------------------------------------------------------------------===//
func parsedURL() *url.URL {

	return &url.URL{
		Scheme:   "http",
		Opaque:   "",
		User:     (*url.Userinfo)(nil),
		Host:     "173.246.108.142",
		Path:     "/level2.php",
		RawPath:  "",
		RawQuery: "",
		Fragment: "",
	}
}

//===--Function clientPost()-----------------------------------------------===//
// clientPost() is used to fill the form for que POST request.
//===----------------------------------------------------------------------===//
func clientPost() (q *url.Values) {
	q = &url.Values{
		"id":          {"23"},
		"holdthedoor": {"Submit"},
		"key":         {cookie},
	}
	return
}

//===--Function customHeader()---------------------------------------------===//
// customHeader() is used to define the request Header without function helpers.
// It uses the format of the http.Header Struct used by net/http package.
//===----------------------------------------------------------------------===//
func customHeader() *http.Header {
	return &http.Header{
		"User-Agent":   {"Windows NT 1000.1.1.1.1.1"},
		"Content-type": {"application/x-www-form-urlencoded"},
		"Cookie":       {"HoldTheDoor=" + cookie},
		"Referer":      {"http://173.246.108.142/level2.php"},
		"Connection":   {"keep-alive"},
	}
}
