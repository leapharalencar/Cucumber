import supertest from "supertest";
import chai from "chai";
import mongodb from "mongodb";
import lodash from "lodash";

global._ = lodash;

global.request = supertest("https://nbooks.herokuapp.com")
global.expect = chai.expect;

global.MongoClient = mongodb.MongoClient;
global.mongo_uri = "mongodb://nbooks-root:root@ds119810.mlab.com:19810/nbooks"