# encoding: UTF-8
@elasticsearch_object = <<-eos
{
  "took" : 1324,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "hits" : {
    "total" : 2,
    "max_score" : 0.11506981,
    "hits" : [ {
      "_index" : "techniques",
      "_type" : "technique",
      "_id" : "2",
      "_score" : 0.11506981,
      "fields" : {
        "user_id" : 1,
        "description" : "Ura-Juji-Jime is the fourth variation of the cross lock, Juji-Jime, demonstrated in The Canon Of Judo, the first three being Katate-, Gyaku-, and Nami- Juji-Jime.",
        "name" : "Ura juji jime - 裹十字絞"
      }
    }, {
      "_index" : "techniques",
      "_type" : "technique",
      "_id" : "1",
      "_score" : 0.047945753,
      "fields" : {
        "user_id" : 1,
        "description" : "Baseball choke, or Ura juji jime, is a choke on the Trachea (air choke hold) and blood vessels of the neck, performed at ground fighting from knee on stomach position. This choke is a part of the syllabus of Brazilian Jiu Jitsu, Judo and Budo Ninjutsu.",
        "name" : "Baseball Choke"
      }
    } ]
  },
  "facets" : {
    "description" : {
      "_type" : "terms",
      "missing" : 0,
      "total" : 42,
      "other" : 34,
      "terms" : [ {
        "term" : "ura",
        "count" : 2
      }, {
        "term" : "vessels",
        "count" : 1
      }, {
        "term" : "variation",
        "count" : 1
      }, {
        "term" : "trachea",
        "count" : 1
      }, {
        "term" : "three",
        "count" : 1
      }, {
        "term" : "syllabus",
        "count" : 1
      }, {
        "term" : "stomach",
        "count" : 1
      } ]
    },
    "name" : {
      "_type" : "terms",
      "missing" : 0,
      "total" : 9,
      "other" : 2,
      "terms" : [ {
        "term" : "裹",
        "count" : 1
      }, {
        "term" : "絞",
        "count" : 1
      }, {
        "term" : "字",
        "count" : 1
      }, {
        "term" : "十",
        "count" : 1
      }, {
        "term" : "ura",
        "count" : 1
      }, {
        "term" : "juji",
        "count" : 1
      }, {
        "term" : "jime",
        "count" : 1
      } ]
    },
    "user_id" : {
      "_type" : "statistical",
      "count" : 2,
      "total" : 2.0,
      "min" : 1.0,
      "max" : 1.0,
      "mean" : 1.0,
      "sum_of_squares" : 2.0,
      "variance" : 0.0,
      "std_deviation" : 0.0
    }
  }
}
eos